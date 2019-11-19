require 'csv'
require 'open-uri'

class Chapter < ApplicationRecord
  belongs_to :course
  has_many :contents, dependent: :destroy

  validates :title, presence: true

  scope :desc, -> { order(rank: :desc) }
  scope :asc, -> { order(rank: :asc) }

  def import_contents_from(file)
    CSV.foreach(file.path, :headers => true) do |row|
      content_attributes = row.to_hash
      content = self.contents.new(
        title: content_attributes['title'],
        description: content_attributes['description'],
        content_type: content_attributes['content_type']
      )
      uri = URI.parse(content_attributes['file'])
      content.files.attach(io: open(row.to_hash['file']), filename: File.basename(uri.path)) rescue nil
      content.save
    end
  end
end
