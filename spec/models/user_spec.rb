require 'spec_helper'

describe User do

  context 'validations' do
    let(:invalid_format_emails) do
      ['_emai@email.com', 'dayvtonalmeida@2014@gmail.com', 'mlisi@bol.com,',
        'julinha\\-laís@hotmail.com', 'neusa@agenciaweb,com.br',
        'adcultura@yahoo,com.br', 'lopesmarinho2009@@hotmail.com',
        'venturalu@hotmail.com .br', 'zaelzabalbino@hotmail.co,']
    end

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

      it 'for email' do
        email = 'luiz.cezer@gmail.com'
        user_1 = create :user, email: email
        user_2 = build :user, email: email
        expect(user_1).to be_valid
        expect(user_2).to_not be_valid
        expect(user_2).to have_at_least(1).error_on(:email)
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

      it 'for email' do
        invalid_format_emails.each do |value|
          user = build :user, email: value
          expect(user).not_to be_valid
          expect(user).to have_at_least(1).error_on(:email)
        end
      end
    end

    context 'associations' do
      it { should have_one :account }
    end

  end

end