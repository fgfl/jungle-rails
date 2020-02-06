class Category < ActiveRecord::Base
  has_many :products

  validates :name, length: { minimum: 1, maximum: 50 }
end
