class CreateHittingStats < ActiveRecord::Migration
  def change
    create_table :hitting_stats do |t|
      t.references :player,       index: true, null: false
      t.references :team,         index: true, null: false
      t.integer :year,            null: false
      t.integer :games,           null: false
      t.integer :at_bats,         default: 0, null: false
      t.integer :runs,            default: 0, null: false
      t.integer :singles,         default: 0, null: false
      t.integer :doubles,         default: 0, null: false
      t.integer :triples,         default: 0, null: false
      t.integer :home_runs,       default: 0, null: false
      t.integer :rbi,             default: 0, null: false
      t.integer :stolen_bases,    default: 0, null: false
      t.integer :caught_stealing, default: 0, null: false

      t.timestamps
    end
  end
end
