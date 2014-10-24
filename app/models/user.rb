class User < ActiveRecord::Base
  has_many :accounts
  has_many :accounting_periods


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable,
         :lockable, :timeoutable


  validates :first_name, :last_name, :middle_name, :address, :presence => true
  validates :email, :presence => true, :uniqueness => true

  

  def name
    "#{first_name} #{middle_name} #{last_name}"
  end
end
