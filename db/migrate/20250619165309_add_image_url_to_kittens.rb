class AddImageUrlToKittens < ActiveRecord::Migration[8.0]
  def change
    add_column :kittens, :image_url, :string
  end
end
