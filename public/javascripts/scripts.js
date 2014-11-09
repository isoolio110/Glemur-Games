// // jquery document ready
// function callLetter(){		
// 		$.ajax({
// 			//use GET because we're pulling information
// 			method: "GET",
// 			//get the url from the form
// 			url: "/hangman/callletter",
// 			//we expect the data that we get back to be in JSON
// 			dataType: "JSON",
// 			//we will be sending a hash of our ingredients
// 			data: letter,
// 			success: function(json){
// 				console.log(json);
// 			}
// 		});
// 	};

// $(function() {
// 	$form = $("form[action='/hangman/callletter']");
// 	$form.on("submit", function(e){	
// 		e.preventDefault();
// 		var letter = $(e.target).find("input[name='letter']").val();
// 	callLetter();
// });



