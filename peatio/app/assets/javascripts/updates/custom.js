/******************************************
    File Name: custom.js
    Template Name: Leo.Crypto - Responsive HTML5 Template
    Created By: PSDConvertHTML
	Envato Profile: https://themeforest.net/user/psdconverthtml
	Website: https://psdconverthtml.com
	Version: 1.0 
/*******************************************/

(function($){
"use strict";

/**== loader js ==*/

	$(window).load(function() {
		$(".bg_load").fadeOut("slow");
	})

/**== Menu js ==**/

	$("#cssmenu").menumaker({
		title: "Menu",
		format: "multitoggle"
	});

/**== animation slider ==**/

$('#bootstrap-touch-slider').bsTouchSlider();

/**== jQuery Countdown Plugin ==**/
 
	$(function(){
		var note = $('#note'),
			ts = new Date(2012, 0, 1),
			newYear = true;
		
		if((new Date()) > ts){
			// The new year is here! Count towards something else.
			// Notice the *1000 at the end - time must be in milliseconds
			ts = (new Date()).getTime() + 10*24*60*60*1000;
			newYear = false;
		}
		$('#countdown').countdown({
			timestamp	: ts,
			callback	: function(days, hours, minutes, seconds){
				var message = "";
				message += days + " day" + ( days==1 ? '':'s' ) + ", ";
				message += hours + " hour" + ( hours==1 ? '':'s' ) + ", ";
				message += minutes + " minute" + ( minutes==1 ? '':'s' ) + " and ";
				message += seconds + " second" + ( seconds==1 ? '':'s' ) + " <br />";
				if(newYear){
					message += "left until the new year!";
				}
				else {
					message += "left to 10 days from now!";
				}
				note.html(message);
			}
		});
		
	});

/**== CarouselTicker ==**/
    
	$(window).on("load", function() {
        $("#carouselTicker").carouselTicker();
    })

})(jQuery);


/** google map **/

	function myMap() {
        var mapProp= {
        center:new google.maps.LatLng(40.712775,-74.005973),
        zoom:12,
		styles: [
		   {
			 elementType: 'geometry',
			 stylers: [{color: '#fefefe'}]
		   },
		   {
			 elementType: 'labels.icon',
			 stylers: [{visibility: 'off'}]
		   },
		   {
			 elementType: 'labels.text.fill',
			 stylers: [{color: '#616161'}]
		   },
		   {
			 elementType: 'labels.text.stroke',
			 stylers: [{color: '#f5f5f5'}]
		   },
		   {
			 featureType: 'administrative.land_parcel',
			 elementType: 'labels.text.fill',
			 stylers: [{color: '#bdbdbd'}]
		   },
		   {
			 featureType: 'poi',
			 elementType: 'geometry',
			 stylers: [{color: '#eeeeee'}]
		   },
		   {
			 featureType: 'poi',
			 elementType: 'labels.text.fill',
			 stylers: [{color: '#757575'}]
		   },
		   {
			 featureType: 'poi.park',
			 elementType: 'geometry',
			 stylers: [{color: '#e5e5e5'}]
		   },
		   {
			 featureType: 'poi.park',
			 elementType: 'labels.text.fill',
			 stylers: [{color: '#9e9e9e'}]
		   },
		   {
			 featureType: 'road',
			 elementType: 'geometry',
			 stylers: [{color: '#eee'}]
		   },
		   {
			 featureType: 'road.arterial',
			 elementType: 'labels.text.fill',
			 stylers: [{color: '#3d3523'}]
		   },
		   {
			 featureType: 'road.highway',
			 elementType: 'geometry',
			 stylers: [{color: '#eee'}]
		   },
		   {
			 featureType: 'road.highway',
			 elementType: 'labels.text.fill',
			 stylers: [{color: '#616161'}]
		   },
		   {
			 featureType: 'road.local',
			 elementType: 'labels.text.fill',
			 stylers: [{color: '#9e9e9e'}]
		   },
		   {
			 featureType: 'transit.line',
			 elementType: 'geometry',
			 stylers: [{color: '#e5e5e5'}]
		   },
		   {
			 featureType: 'transit.station',
			 elementType: 'geometry',
			 stylers: [{color: '#000'}]
		   },
		   {
			 featureType: 'water',
			 elementType: 'geometry',
			 stylers: [{color: '#c8d7d4'}]
		   },
		   {
			 featureType: 'water',
			 elementType: 'labels.text.fill',
			 stylers: [{color: '#b1a481'}]
		   }
        ]
    };
        var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);
    }
 