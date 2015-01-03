class Auction < ActiveRecord::Base
  validates :name, :url, presence: true
  validates :url, uniqueness: true
end
