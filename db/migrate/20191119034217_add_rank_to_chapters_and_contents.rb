class AddRankToChaptersAndContents < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :rank, :integer
    add_column :contents, :rank, :integer
  end
end
