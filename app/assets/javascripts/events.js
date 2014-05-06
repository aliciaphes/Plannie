//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready(function() {


	//$("#event_has_length").on('click', function () {
		$(document).on('click', "#event_has_length", function () {

		//NEED TO USE THE EVENT ON document BECAUSE THE WHOLE PAGE GETS REFRESHED. Stackoverflow: the .on should be executed on a parent element that doesnt change or document.

	//.change(function() {
		//alert("clicked");
		//console.log("Clicked");

		//$("#hidden_to_field").attr('disabled', !$(this).attr('checked'));
		//if ($(this).prop('checked'))

		$("#hidden_to_field").toggle();

	});


	if($("#event_has_length").is(':checked')){
		//alert("is checked");
		$("#hidden_to_field").show();
	}		
	else $("#hidden_to_field").hide();
	

/*
$("#event_has_length").each(function () {
            $this = $(this);
            if ($this.is(':checked')) {
            	alert("is checked");
                $("#hidden_to_field").show();
            } else {
            	alert("is NOT checked");
                $("#hidden_to_field").hide();
            }
});
*/


});