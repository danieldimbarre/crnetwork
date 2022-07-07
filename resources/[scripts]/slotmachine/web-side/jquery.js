// -------------------------------------------------------------------------------------------
$(document).ready(function(){
	window.addEventListener("message",function(event){
		if (event["data"]["show"] !== undefined){
			if (event["data"]["show"] == true){
				$("#SlotMachine").css("display","block");
			} else {
				$("#SlotMachine").css("display","none");
			}

			return
		}
	});
});