window.addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "Notify":
			var Html = `<div id='${"Notify-" + event["data"]["Css"]}'>${event["data"]["Message"]}</div>`;
			$(Html).fadeIn(500).appendTo("#Notify").delay(event["data"]["Timer"]).fadeOut(500,function(){ this.remove() });
		break;
	}
});