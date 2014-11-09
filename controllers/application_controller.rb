class ApplicationController < Sinatra::Base

  helpers AuthenticationHelper

  enable :sessions
  enable :method_override

  register Sinatra::ActiveRecordExtension

  set :database, {adapter: "postgresql", database: "glemur_games_db"}
  set :views, File.expand_path("../../views", __FILE__)
  set :public_folder, File.expand_path("../../public", __FILE__)

  get '/' do
    if current_user
      erb :'game_menu/index'
    else
      erb :index
    end
  end

  get '/games' do
    erb :'game_menu/index'
  end

  get '/scoreboard' do
    erb :'scoreboard/index'
  end

  get '/profile' do
    erb :'profile/index'
  end

  get '/hangman' do
    # select a random game word
    words = Word.all
    word = words.sample
    @word_text = word.word_text
    # create a new instance of hangmangame
    hangmangame = HangmanGame.create(
      {word_id: word.id,
      user_id: current_user.id}
      )
    @hangmangame_id = hangmangame.id
    # create an array of the game word letters
    word_id = hangmangame.word_id
    word = Word.find(word_id)
    game_word = word.word_text
    @game_word_letters = game_word.upcase.split('')
    # create an array of letters from A-Z for buttons
    @letters_arr = ("A".."Z").to_a
    # create game state
    if hangmangame.game_state == nil
      game_words_letter_count = @game_word_letters.count
      game_state = Array.new(game_words_letter_count,'?')
      game_state = game_state.join("")
      hangmangame.update(game_state: game_state)
    end
    @wins = current_user.hangman_games.where(win: 1).count
    @losses = current_user.hangman_games.where(loss: 1).count
    # erb
    erb :'hangman/index'
  end

  get '/hangman/callletter' do

    content_type :json
    # get the guessed letter
    guessed_letter = params[:letter]
    # need to find the game word
    hangmangame = HangmanGame.find(params[:hangmangame_id])
    word = hangmangame.word
    game_word = word.word_text
    game_word_letters = game_word.upcase.split('')
    index_of_correct_letters = []
    # check whether guessed letter is in the word
    # if guessed word != game word, then update # of bad guesses
    if game_word_letters.include?(guessed_letter) == false
      new_num_of_bad_guesses = hangmangame.num_bad_guesses.to_i + 1
      hangmangame.update(num_bad_guesses: new_num_of_bad_guesses)
    else
      # update 'in word' to true
      hangmangame.update(in_word: true)
      # create array of indexes for correctly guessed letters
      game_word_letters.each_with_index do |game_letter, index|
        if game_letter == guessed_letter
                index_of_correct_letters << index
          end
        end
    end
    # update the game as being lost if bad guesses is == 5
    if hangmangame.num_bad_guesses.to_i == 6
      hangmangame.update(loss: 1)
    end

    # update the game state
    game_state = hangmangame.game_state.dup
    index_of_correct_letters.each do |index|
        game_state[index] = guessed_letter
      end
    hangmangame.game_state = game_state
    hangmangame.save

    # update the game as being won if game state does not include any question marks
    if hangmangame.game_state.include?("?") == false
      hangmangame.update(win: 1)
    end

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

  get '/tictactoe' do
    erb :'tictactoe/index'
  end

end







