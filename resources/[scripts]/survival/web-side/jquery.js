// -------------------------------------------------------------------------------------------
window.addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "Display":
			$("#SurvivalText").css("display",event["data"]["Mode"]);
		break;

		case "Message":
			$("#SurvivalText").html(event["data"]["Message"]);
		break;
	}
});