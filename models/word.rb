class Word < ActiveRecord::Base
  has_many :hangman_games
  has_many :users, through: :hangman_games
end

