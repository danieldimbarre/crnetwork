window.addEventListener("load",function(){
	window.addEventListener("message",function(event){
		if (event["data"]["death"] == true){
			$("#deathDiv").css("display","block");
		}

		if (event["data"]["death"] == false){
			$("#deathDiv").css("display","none");
		}

		if (event["data"]["deathtext"] !== undefined){
			$("#deathText").html(data["deathtext"]);
		}
	});
});