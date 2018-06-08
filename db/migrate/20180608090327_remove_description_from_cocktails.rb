class RemoveDescriptionFromCocktails < ActiveRecord::Migration[5.2]
  def change
    remove_column :cocktails, :description
  end
end
