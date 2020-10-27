require 'rails_helper'

RSpec.describe Document, type: :model do
  context 'Document model validations' do
    let (:valid_user) { User.create({
      user_name: 'bond007doc',
      full_name: 'Kunal Mehta',
      email: 'knlmht2@gmail.com',
      password: 'Test1234'
    }) }
    it 'files are not shared by default' do
      document = valid_user.documents.create(key: 'unique.123')
      expect(document.shared).to be false 
    end
    it 'key can not be empty' do
      document = valid_user.documents.create(key: '')
      expect(document.errors[:key].any?).to be true 
    end
    it 'key should be unique' do
      document1 = valid_user.documents.new({key: 'new123'})
      document2 = valid_user.documents.new({key: 'new123'})
      document1_saved = document1.save
      document2_saved = document2.save
      expect(document1_saved).to be true 
      expect(document1.errors[:key].any?).to be false
      expect(document2_saved).to be false 
      expect(document2.errors[:key].any?).to be true
    end
    it 'active storage file attached' do
      document = valid_user.documents.create(key: 'random12345')
      document.user_document.attach(
        io: File.open("#{Rails.root}/spec/data/temp.txt"), 
        filename: "temp.txt",
        content_type: "application/x-ruby"
      )
      expect(document.user_document).to be_attached
    end
  end
end
