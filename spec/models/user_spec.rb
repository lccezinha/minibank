require 'spec_helper'

describe User do

  context 'validations' do

    context 'presence' do
      [:name, :cpf, :password, :email].each do |field|
        it { should validate_presence_of field  }
      end
    end

    context 'uniqueness' do
      it 'for cpf' do
        cpf = '01234567891'
        user_1 = create :user, cpf: cpf
        user_2 = build :user, cpf: cpf
        expect(user_1).to be_valid
        expect(user_2).to_not be_valid
        expect(user_2).to have_at_least(1).error_on(:cpf)
      end
    end

    context 'format' do
      it 'for cpf' do
        ['123.321.312-93', '123123123123123', '123123'].each do |value|
          user = build :user, cpf: value
          expect(user).to_not be_valid
          expect(user).to have_at_least(1).error_on(:cpf)
        end
      end
    end

  end

end