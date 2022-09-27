var Networked = false;
// -------------------------------------------------------------------------------------------
window.addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "Show":
			$("#SlotMachine").css("display","block");
		break;

		case "Hide":
			$("#SlotMachine").css("display","none");
		break;
	}
});
// -------------------------------------------------------------------------------------------
setInterval(() => {
	if (navigator.onLine != Networked){
		Networked = navigator.onLine
		$.post("http://slotmachine/Network",JSON.stringify({ status: Networked }));
	}
},500)