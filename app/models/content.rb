class Content < ApplicationRecord
  enum content_type: [ :text, :audio, :video, :pdf, :download ]

  belongs_to :chapter

  has_many_attached :files

  validates :title, presence: true
  validates :files , attached: true, content_type: ['application/pdf'], if: Proc.new{|content| content.pdf? }
  validates :files , attached: true,
            content_type: ['audio/mp3', 'audio/mpeg', 'audio/wav'],
            size: { less_than: 100.megabytes , message: 'is large in size' },
            if: Proc.new{|content| content.audio? }

  validates :files , attached: true,
            content_type: ['video/mp4', 'video/x-msvideo', 'video/quicktime'],
            size: { less_than: 200.megabytes , message: 'is large in size' },
            if: Proc.new{|content| content.video? }

end
