class ChangeDataTagIdToTaggings < ActiveRecord::Migration[6.1]
  def change
    change_column :taggings, :tag_id, :bigint
  end
end
