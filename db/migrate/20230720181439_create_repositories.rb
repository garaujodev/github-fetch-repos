class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories do |t|
      t.string :owner
      t.string :name
      t.integer :stars

      t.timestamps
    end

    add_index :repositories, [:owner, :name], unique: true
  end
end
