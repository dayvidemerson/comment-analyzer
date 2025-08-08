require 'rails_helper'

RSpec.describe Importer::User, type: :model do
  ActiveJob::Base.queue_adapter = :test

  describe 'validations' do
    it { is_expected.to define_enum_for(:state).with_values(pending: 0, processing: 1, completed: 2, error: 3) }
  end

  describe 'callbacks' do
    it 'schedules import after create' do
      importer = build(:importer_user)

      expect { importer.save! }.to have_enqueued_job(ImporterJob).with(importer.id)
    end
  end

  describe '#run!' do
    let(:importer) { create(:importer_user, key: 'Bret') }
    let(:user_data) do
      {
        'name' => 'Leanne Graham',
        'username' => 'Bret',
        'email' => 'Sincere@april.biz',
        'phone' => '1-770-736-8031 x56442',
        'website' => 'hildegard.org',
        'company' => {
          'name' => 'Romaguera-Crona',
          'catchPhrase' => 'Multi-layered client-server neural-net',
          'bs' => 'harness real-time e-markets'
        },
        'address' => {
          'street' => 'Kulas Light',
          'suite' => 'Apt. 556',
          'city' => 'Gwenborough',
          'zipcode' => '92998-3874',
          'geo' => {
            'lat' => '-37.3159',
            'lng' => '81.1496'
          }
        }
      }
    end

    context 'when state is not pending' do
      before { importer.update!(state: :processing) }

      it 'does not process the import' do
        expect { importer.run! }.not_to change(User, :count)
      end
    end

    context 'when user is found' do
      before do
        allow(JsonPlaceHolder::User).to receive(:where)
          .with(username: 'Bret')
          .and_return([ user_data ])
      end

      it 'creates user with associated records' do
        expect { importer.run! }.to change(User, :count).by(1)
          .and change(Company, :count).by(1)
          .and change(Address, :count).by(1)

        user = User.last
        expect(user.name).to eq('Leanne Graham')
        expect(user.username).to eq('Bret')
        expect(user.email).to eq('Sincere@april.biz')
        expect(user.phone).to eq('1-770-736-8031 x56442')
        expect(user.website).to eq('hildegard.org')

        expect(user.company.name).to eq('Romaguera-Crona')
        expect(user.company.catch_phrase).to eq('Multi-layered client-server neural-net')
        expect(user.company.bs).to eq('harness real-time e-markets')

        expect(user.address.street).to eq('Kulas Light')
        expect(user.address.suite).to eq('Apt. 556')
        expect(user.address.city).to eq('Gwenborough')
        expect(user.address.zipcode).to eq('92998-3874')
        expect(user.address.latitude).to eq('-37.3159')
        expect(user.address.longitude).to eq('81.1496')
      end

      it 'updates importer state to completed' do
        importer.run!
        expect(importer.reload.state).to eq('completed')
      end
    end

    context 'when user is not found' do
      before do
        allow(JsonPlaceHolder::User).to receive(:where)
          .with(username: 'Bret')
          .and_return([])
      end

      it 'does not create any records' do
        expect { importer.run! }.not_to change(User, :count)
      end

      it 'updates importer state to completed' do
        importer.run!
        expect(importer.reload.state).to eq('completed')
      end
    end

    context 'when an error occurs' do
      before do
        allow(JsonPlaceHolder::User).to receive(:where)
          .and_raise(JsonPlaceHolder::Error.new('API Error'))
      end

      it 'updates state to error' do
        importer.run!
        expect(importer.reload.state).to eq('error')
      end

      it 'does not create any records' do
        expect { importer.run! }.not_to change(User, :count)
      end
    end

    it 'updates state to processing when starting' do
      allow(JsonPlaceHolder::User).to receive(:where).and_return([])

      expect { importer.run! }
        .to change { importer.reload.state }
        .from('pending')
        .to('completed')
    end
  end
end
