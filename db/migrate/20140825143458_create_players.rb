class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :code
      t.string :birth_year
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
