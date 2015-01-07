class HangmanGame < ActiveRecord::Base
  belongs_to :user
  belongs_to :word

  # before_create will call these methods
  # after .new but before saving to db
  before_create :create_game_state

  def game_state=(val)
    game_state_will_change!
    write_attribute(:game_state, val)
  end

  def create_game_state
    # get a random word
    word = Word.all.sample
    # set this hangmangame's word to that word
    self.word = word
    # set this hangmangame's game_state to question marked word text
    self.game_state = self.word.word_text.gsub(/[\w]/, "?")
  end

  def update_num_of_bad_guesses(guessed_letter)
    # split the game word characters into an array
    game_word_letters = self.word.word_text.upcase.split('')
    # if the guessed letter is NOT in the game word:
    if game_word_letters.include?(guessed_letter) == false
      # duplicate num_bad_guesses just in case we have database issues
      if self.num_bad_guesses == nil
        num_bad_guesses = 0
      else num_bad_guesses = self.num_bad_guesses
      end
      # increase the count of bad guesses by 1
      self.num_bad_guesses = num_bad_guesses + 1
      self.save
    end
  end

  def update_game_state(guessed_letter, index_of_correct_letters=[])
    # split the game word characters into an array
    game_word_letters = self.word.word_text.upcase.split('')
    # if the guessed letter IS in the game word:
    if game_word_letters.include?(guessed_letter) == true
      # set in_word to true
      self.in_word = true
      # create array of indexes for correctly guessed letters
      game_word_letters.each_with_index do |game_letter, index|
        if game_letter == guessed_letter
              index_of_correct_letters << index
        end
      end
      # save a duplicate of the game state to avoid database issues
      game_state = self.game_state.dup
      # go through each of the index positions for the correctly guessed letter
      index_of_correct_letters.each do |index|
          # update the game state string at those index positions with the letter
          game_state[index] = guessed_letter
      end
      self.game_state = game_state
      self.save
    end
  end

  def update_losses
    # if the number of guesses equals to 6, then player has lost
    if self.num_bad_guesses.to_i == 6
      self.loss = 1
      self.save
    end
  end

  def update_wins
    # if the game state no longer has any question marks, the player has won
    if self.game_state.include?("?") == false
      self.win = 1
      self.save
    end
  end


end


