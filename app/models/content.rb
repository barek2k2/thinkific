class Content < ApplicationRecord
  enum content_type: [ :text, :audio, :video, :pdf, :download ]

  belongs_to :chapter

  has_many_attached :files

  validates :title, presence: true

end
