window.addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "Notify":
			var Html = `<div id='${"Notify-" + event["data"]["Css"]}'>${event["data"]["Message"]}</div>`;
			$(Html).fadeIn(500).appendTo("#Notify").delay(event["data"]["Timer"]).fadeOut(500,function(){ this.remove() });
		break;

		case "Shortcuts":
			if (event["data"]["Shortcuts"] == true){
				if ($("#Shortcuts").css("display") === "none"){
					$("#Shortcuts").css("display","flex");
				}

				$(".Shorts-1").attr("data-value","1");
				$(".Shorts-2").attr("data-value","2");
				$(".Shorts-3").attr("data-value","3");
				$(".Shorts-4").attr("data-value","4");
				$(".Shorts-5").attr("data-value","5");

				if (event["data"]["Shorts"][1] !== ""){
					$(".Shorts-1").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["Shorts"][1]}.png)`);
				} else {
					$(".Shorts-1").css("background-image","none");
				}

				if (event["data"]["Shorts"][2] !== ""){
					$(".Shorts-2").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["Shorts"][2]}.png)`);
				} else {
					$(".Shorts-2").css("background-image","none");
				}

				if (event["data"]["Shorts"][3] !== ""){
					$(".Shorts-3").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["Shorts"][3]}.png)`);
				} else {
					$(".Shorts-3").css("background-image","none");
				}

				if (event["data"]["Shorts"][4] !== ""){
					$(".Shorts-4").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["Shorts"][4]}.png)`);
				} else {
					$(".Shorts-4").css("background-image","none");
				}

				if (event["data"]["Shorts"][5] !== ""){
					$(".Shorts-5").css("background-image",`url(nui://inventory/web-side/images/${event["data"]["Shorts"][5]}.png)`);
				} else {
					$(".Shorts-5").css("background-image","none");
				}
			} else {
				if ($("#Shortcuts").css("display") === "flex"){
					$("#Shortcuts").css("display","none");
				}
			}
		break;
	}
});