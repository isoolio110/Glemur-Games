class HangmanGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  def game_state=(val)
    game_state_will_change!
    write_attribute(:game_state, val)
  end


end


