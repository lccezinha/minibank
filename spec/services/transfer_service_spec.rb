require 'spec_helper'

describe TransferService do
  context 'run transfer from A to B' do
    let(:user) { create :user }
    let(:user_two) { create :user }

    let(:account) { create :account, user_id: user.id }
    let(:account_two) { create :account, user_id: user_two.id }

    it 'create one Movimentation with operation: transfer' do
      quantity = 50
      transfer = Transfer.new account_id: account.id, account_destiny_id: account_two.id,
        quantity: quantity
      transfer_service = TransferService.new transfer
      expect { transfer_service.run }.to change(Movimentation, :count).by(1)
      expect(Movimentation.last.operation).to eql('transfer')
    end

    it 'add quantity for in destiny account' do
      quantity = 50
      transfer = Transfer.new account_id: account.id, account_destiny_id: account_two.id,
        quantity: quantity
      transfer_service = TransferService.new transfer
      expect { transfer_service.run }.to
        change(account_two, :total).from(account_two.total).to(account_two.total + quantity)
    end

    it 'account_id and account_destiny_id can not be equal' do
      account = create :account
      account_two = create :account
      transfer = Transfer.new account_id: account.id,
        account_destiny_id: account.id, quantity: 50
      expect(transfer).not_to be_valid
      expect(transfer.errors.keys).to include(:account_destiny_id)
      expect(transfer.errors[:account_destiny_id]).to include('Conta destino não pode ser a conta de origem')
    end

  end
end