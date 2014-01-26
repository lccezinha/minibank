require 'spec_helper'

describe TransferService do
  context 'run transfer from A to B' do
    let(:user) { create :user }
    let(:user_two) { create :user }

    let(:account) { create :account, user_id: user.id }
    let(:account_two) { create :account, user_id: user_two.id }

    let(:quantity) { BigDecimal.new(50) }

    context 'tax value' do
      it do
        week_day_comercial_hour = DateTime.new(2014, 01, 24, 10, 00, 00)
        expect(tax_by_date(week_day_comercial_hour, quantity)).to eql(TransferService::TAXES[:business_hour])
      end

      it do
        week_day_off_comercial_hour = DateTime.new(2014, 01, 25, 10, 00, 00)
        expect(tax_by_date(week_day_off_comercial_hour, quantity)).to eql(TransferService::TAXES[:off_business_hour])
      end

      it do
        weekend = DateTime.new(2014, 01, 24, 20, 00, 00)
        expect(tax_by_date(weekend, quantity)).to eql(TransferService::TAXES[:weekend])
      end

      context 'when quantity > 1000 add more 10 in tax' do
        let(:quantity) { 1500 }
        it do
          week_day_comercial_hour = DateTime.new(2014, 01, 24, 10, 00, 00)
          expect(tax_by_date(week_day_comercial_hour, quantity)).to eql(TransferService::TAXES[:business_hour] + 10)
        end

        it do
          week_day_off_comercial_hour = DateTime.new(2014, 01, 25, 10, 00, 00)
          expect(tax_by_date(week_day_off_comercial_hour, quantity)).to eql(TransferService::TAXES[:off_business_hour] + 10)
        end

        it do
          weekend = DateTime.new(2014, 01, 24, 20, 00, 00)
          expect(tax_by_date(weekend, quantity)).to eql(TransferService::TAXES[:weekend] + 10)
        end
      end
    end

    it 'create one Movimentation with operation: transfer' do
      transfer = Transfer.new account_id: account.id, account_destiny_id: account_two.id,
        quantity: quantity
      transfer_service = TransferService.new transfer
      expect { transfer_service.run }.to change(Movimentation, :count).by(1)
      expect(Movimentation.last.operation).to eql('transfer')
    end

    context 'fail when ' do
      it 'account_id does not have enough money' do
        account = create :account, total: BigDecimal.new(20)
        transfer = Transfer.new account_id: account.id, account_destiny_id: account_two.id,
          quantity: quantity
        transfer_service = TransferService.new transfer
        expect { transfer_service.run }.not_to change(Movimentation, :count).by(1)
      end
      context 'required fiels is not present' do
        it 'account_destiny_id' do
          transfer = Transfer.new account_id: account.id, account_destiny_id: '',
            quantity: quantity
          transfer_service = TransferService.new transfer
          expect { transfer_service.run }.not_to change(Movimentation, :count).by(1)
        end
        it 'quantity' do
          transfer = Transfer.new account_id: account.id, account_destiny_id: account_two.id,
            quantity: ''
          transfer_service = TransferService.new transfer
          expect { transfer_service.run }.not_to change(Movimentation, :count).by(1)
        end
      end
    end

    it 'add quantity for in destiny account' do
      transfer = Transfer.new account_id: account.id, account_destiny_id: account_two.id,
        quantity: quantity
      transfer_service = TransferService.new transfer

      initial = account.total
      final = initial + quantity

      expect {
        transfer_service.run
      }.to change { account_two.reload.total }.from(initial).to(final)
    end

    it 'discount quantity for in account' do
      transfer = Transfer.new account_id: account.id, account_destiny_id: account_two.id,
        quantity: quantity
      transfer_service = TransferService.new transfer

      initial = account.total
      tax = tax_by_date(DateTime.now, quantity)
      final = initial - (quantity + tax)

      expect {
        transfer_service.run
      }.to change { account.reload.total }.from(initial).to(final)
    end

    it 'account_id and account_destiny_id can not be equal' do
      account = create :account
      account_two = create :account
      transfer = Transfer.new account_id: account.id,
        account_destiny_id: account.id, quantity: quantity
      expect(transfer).not_to be_valid
      expect(transfer.errors.keys).to include(:account_destiny_id)
      expect(transfer.errors[:account_destiny_id]).to include('Conta destino não pode ser a conta de origem')
    end
  end
end