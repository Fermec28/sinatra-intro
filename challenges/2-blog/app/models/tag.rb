class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_many :entry_tags
  has_many :entries, through: :entry_tags
  validates :content, presence: true
  
end
