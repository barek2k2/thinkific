class Content < ApplicationRecord

  belongs_to :chapter

  has_many_attached :files

end
