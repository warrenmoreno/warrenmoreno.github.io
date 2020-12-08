"use strict"
/* 

Original Author: Warren Moreno
Date Created: September 25th, 2019
Version: 
Date Last Modified: 
Modified by: Warren Moreno
Modification log: 
Filename: time_n_calendar.js

*/

/* Execute the function to run and display the countdown clock */
runClock();
setInterval("runClock()", 1000);

/* Function to create and run the countdown clock */
function runClock() {
	
	/* Store the current date and time */
	var currentDay = new Date();
	var dateStr = currentDay.toLocaleDateString();
	var timeStr = currentDay.toLocaleTimeString();


	/* Display the current date and time */
	document.getElementById("dateNow").innerHTML = 
	dateStr + "<br />" + timeStr;
}