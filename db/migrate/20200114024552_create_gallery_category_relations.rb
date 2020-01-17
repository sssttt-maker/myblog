class CreateGalleryCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :gallery_category_relations do |t|
      t.references :gallery, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps

      t.index [:gallery_id, :category_id], unique: true
    end
  end
end
