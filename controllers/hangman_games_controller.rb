class HangmanGamesController < ApplicationController

  get '/' do
    # create a new instance of hangmangame
    @hangmangame = HangmanGame.create(
      {
        user_id: current_user.id}
      )
    # create an array of the game word letters
    @game_word_letters = @hangmangame.word.word_text.upcase.split('')
    # create an array of letters from A-Z for buttons
    @letters_arr = ("A".."Z").to_a
    # get total wins and losses per player
    @wins = current_user.hangman_games.where(win: 1).count
    @losses = current_user.hangman_games.where(loss: 1).count
    erb :'hangman/index'
  end

  get '/callletter' do
    content_type :json
    # get the guessed letter
    guessed_letter = params[:letter]
    # find the hangmangame
    hangmangame = HangmanGame.find(params[:hangmangame_id])
    # update number of bad guesses
    hangmangame.update_num_of_bad_guesses(guessed_letter)
    # check whether guessed letter is in the word & update game state
    hangmangame.update_game_state(guessed_letter)
    # update the game as being lost if bad guesses is == 5
    hangmangame.update_losses
    # update the game as being won if game state does not include any question marks
    hangmangame.update_wins
    # get the cumulative scores
    wins = current_user.hangman_games.where(win: 1).count
    losses = current_user.hangman_games.where(loss: 1).count
    # send the response via json
    {
      game_state: hangmangame.game_state,
      num_bad_guesses: hangmangame.num_bad_guesses,
      wins: wins,
      losses: losses,
      current_game_win: hangmangame.win,
      current_game_loss: hangmangame.loss
    }.to_json
  end

end


