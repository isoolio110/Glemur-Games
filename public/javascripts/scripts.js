//*******************************************************
// Hangman Games Page
//*******************************************************

//************************************
// Show Hangman Images
//************************************

function showImages(num_bad_guesses){
	if(num_bad_guesses < 7) {
		$("#hangman_img").attr("src","imgs/Hangman"+(num_bad_guesses+1)+".png");
	}; 
};

//************************************
// Show Number of Total Wins
//************************************

function showWins(wins){
	if(wins > 0) {
	$("#wins").html(wins);	
	};	
};

//************************************
// Show Number of Total Losses
//************************************

function showLosses(losses){
	if(losses > 0) {
	$("#losses").html(losses);	
	};	
};
                                                          
//************************************
// Populate Guess Boxes with Guessed Letters
//************************************

function populateGuessSpots(game_state,num_bad_guesses){
	game_state_array = game_state.split("");
	if (num_bad_guesses < 7) {
		$.each(game_state_array, function( index, value ) {
		    $guessDisplay = $("#guess_letter_"+index);
		    $guessDisplay.text(value);	    
		});		
	};	
};

//************************************
// Alert Player that He/She has Won
//************************************
function alertWin(current_game_win){
	if(current_game_win === 1) {
		alert("Yay! You Won!");
	};
};

//************************************
// Alert Player that He/She has Won
//************************************
function alertLoss(current_game_loss){
	if(current_game_loss === 1) {
		alert("Oh No, You Lost!");
	};
};

//************************************
// Function to Run Upon Successful Ajax Call
//************************************

function updatepage(data){
	console.log(data);
	console.log(data.num_bad_guesses);
	console.log(data.wins);
	console.log(data.losses);
	console.log(data.game_state);
	console.log(data.current_game_win);
	console.log(data.current_game_loss);
	populateGuessSpots(data.game_state,data.num_bad_guesses);
	showImages(data.num_bad_guesses);
	showWins(data.wins);
	showLosses(data.losses);
	alertWin(data.current_game_win);
	alertLoss(data.current_game_loss);
};



