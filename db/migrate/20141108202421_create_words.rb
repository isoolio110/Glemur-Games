class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word_text
    end
  end
end

