class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_account

  delegate :total, to: :account, prefix: true

  validates_presence_of :name, :cpf, :email
  validates_uniqueness_of :email, :cpf
  validates_format_of :cpf, with: /\A\d{11}\z/
  validates_format_of :email, with: Devise.email_regexp

  has_one :account

  protected

  def generate_account
    create_account
  end

end
