require 'rails_helper'

RSpec.describe JsonPlaceHolder::User do
  describe '.all' do
    it 'returns all users', vcr: { cassette_name: 'json_place_holder/users/all' } do
      users = described_class.all

      expect(users).to be_an(Array)
      expect(users.first).to include(
        'id' => be_an(Integer),
        'name' => be_a(String),
        'username' => be_a(String),
        'email' => be_a(String)
      )
    end
  end

  describe '.find' do
    it 'returns a specific user by ID', vcr: { cassette_name: 'json_place_holder/users/find' } do
      user = described_class.find(1)

      expect(user).to include(
        'id' => 1,
        'name' => be_a(String),
        'username' => be_a(String),
        'email' => be_a(String)
      )
    end

    it 'raises error when user does not exist', vcr: { cassette_name: 'json_place_holder/users/find_not_found' } do
      expect { described_class.find(999) }.to raise_error(JsonPlaceHolder::Error)
    end
  end

  describe '.where' do
    it 'returns a user by username', vcr: { cassette_name: 'json_place_holder/users/where_username' } do
      users = described_class.where(username: 'Bret')

      expect(users).to be_an(Array)
      expect(users.first).to include(
        'username' => 'Bret'
      )
    end

    it 'returns empty array when no user is found', vcr: { cassette_name: 'json_place_holder/users/where_username_not_found' } do
      users = described_class.where(username: 'nonexistent_user')
      expect(users).to be_empty
    end
  end
end
