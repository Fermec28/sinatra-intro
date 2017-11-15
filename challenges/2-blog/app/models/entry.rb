class Entry < ActiveRecord::Base
  # Remember to create a migration!
  #has_many: entry_tags
  has_many :entry_tags
  has_many :tags, through: :entry_tags

  validates :autor, :title, :content, presence: true 

end
