//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://coffeescript.org/


$( document ).ready(function() {

	$("#event_has_length").change(function() {
		//alert("clicked");
		$("#event_endda").attr('disabled', !$(this).attr('checked'));
	});



});