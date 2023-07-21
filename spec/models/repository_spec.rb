require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe 'validations' do
    it 'is valid with all required attributes' do
      repository = Repository.new(name: 'rails', owner: 'rails', stars: 1000)
      expect(repository).to be_valid
    end

    it 'is invalid without a name' do
      repository = Repository.new(owner: 'rails', stars: 1000)
      expect(repository).to_not be_valid
    end

    it 'is invalid without an owner' do
      repository = Repository.new(name: 'rails', stars: 1000)
      expect(repository).to_not be_valid
    end

    it 'is invalid without stars' do
      repository = Repository.new(name: 'rails', owner: 'rails')
      expect(repository).to_not be_valid
    end

    it 'is invalid with a duplicate name and owner combination' do
      existing_repository = Repository.create(name: 'rails', owner: 'rails', stars: 1000)
      new_repository = Repository.new(name: 'rails', owner: 'rails', stars: 2000)

      expect(new_repository).to_not be_valid
    end

    it 'is valid with the same name but different owners' do
      existing_repository = Repository.create(name: 'rails', owner: 'rails', stars: 1000)
      new_repository = Repository.new(name: 'rails', owner: 'other_owner', stars: 2000)

      expect(new_repository).to be_valid
    end
  end
end
