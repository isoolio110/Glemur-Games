class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word_text, null: false
      t.timestamps
    end
  end
end

