class CreateHangmanGames < ActiveRecord::Migration
  def change
    create_table :hangman_games do |t|
      t.integer :user_id
      t.integer :word_id
      t.string :game_state
      t.integer :num_bad_guesses
      t.boolean :last_guess
      t.boolean :in_word
      t.integer :win
      t.integer :loss
      t.timestamps
    end
  end
end
