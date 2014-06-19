//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready(function() {


	$("#event_has_length").on('click', function () {
	//$(document).on('click', "#event_has_length", function () {

		//need to use the event on DOCUMENT because the whole page gets refreshed. Stackoverflow: the .on should be executed on a parent element that doesnt change or document.

	//.change(function() {
		//alert("clicked");
		//console.log("Clicked");

		//$("#hidden_to_field").attr('disabled', !$(this).attr('checked'));
		//if ($(this).prop('checked'))

		//$("#hidden_to_field").toggle();



		if($("#event_has_length").is(':checked')){
			//alert("is checked");
			$("#hidden_to_field").show();
			$("#time_label").html("From");
		}		
		else{
			$("#hidden_to_field").hide();
			$("#time_label").html("At");
		}



});


		if($("#event_has_length").is(':checked')){
			$("#hidden_to_field").show();
			$("#time_label").html("From");
		}		
		else{
			$("#hidden_to_field").hide();
			$("#time_label").html("At");
		}



	$(document).on('click', ".clickable_row", function () {
        //window.document.location = $(this).data('url');
        $(location).attr('href', $(this).data('url'));
    });


	$(".clickable_row").hover(
	  function() {
	    $(this).addClass("row_hovered");

	  }, function() {
	    $(this).removeClass("row_hovered");
	  }
	);

	$("#popup").on('click', function () {
//use http://jqueryui.com/dialog/#modal-form
//or angular: http://codepen.io/ionic/pen/zkmhJ?editors=101
// or this: http://jsfiddle.net/cUfYw/
    });
 



//------------add red color to search term----------------------
var title = $("span[class='search']").html();
//alert(title);
var search_term = $("h2[class='search']").data("search-term");
//alert(search_term);
var index = title.indexOf(search_term);
var found = title.substr(index, search_term.length); //start, length
var piece = "<span class='red'>"+found+"</span>";
//alert(piece);


//FROM <span class="search">Movie</span>
// if I search for 'ov' it should change
//TO   M<span>ov</span>ie

//convert html:
$("span[class='search_title']").html(title.substr(0, index)+piece+title.substr(index+search_term.length, title.length));
//------------end of add red color to search term----------------------







}); //document.ready