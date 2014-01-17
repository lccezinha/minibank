require 'spec_helper'

describe Extract do
  context 'validations' do
    context 'presence' do
      [:start_date, :end_date].each do |field|
        it { should validate_presence_of field  }
      end
    end
  end
end