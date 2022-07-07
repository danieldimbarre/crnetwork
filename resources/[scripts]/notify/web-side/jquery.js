$(document).ready(function(){
	window.addEventListener("message",function(event){
		if (event["data"]["Message"] !== undefined){
			var html = `<div id='${event["data"]["Css"]}'>${event["data"]["Message"]}</div>`;
			$(html).fadeIn(500).appendTo("#notifications").delay(event["data"]["Timer"]).fadeOut(500);
		}
	});
});