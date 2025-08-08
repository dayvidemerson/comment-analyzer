FactoryBot.define do
  factory :importer_user, class: 'Importer::User' do
    state { :pending }
  end
end
