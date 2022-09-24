var ChatTime = 0;
var Voip = "Normal";
var Chat = undefined;
var Networked = false;
var Interval = undefined;
// -------------------------------------------------------------------------------------------
function Minimal(Seconds){
	var Days = Math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	var Hours = Math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	var Minutes = Math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	const [D,H,M,S] = [Days,Hours,Minutes,Seconds].map(s => s.toString().padStart(2,0))

    if (Days > 0){
        return D + ":" + H
    } else if (Hours > 0){
        return H + ":" + M
    } else if (Minutes > 0){
        return M + ":" + S
    } else if (Seconds > 0){
        return "00:" + S
    }
}
// -------------------------------------------------------------------------------------------
setInterval(() => {
	if (navigator.onLine != Networked){
		Networked = navigator.onLine
		$.post("http://hud/Network",JSON.stringify({ status: Networked }));
	}
},500)
// -------------------------------------------------------------------------------------------
const FormatNumber = n => {
	var n = n.toString();
	var r = "";
	var x = 0;

	for (var i = n["length"]; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
		x = x == 2 ? 0 : x + 1;
	}

	return r.split("").reverse().join("");
}
// -------------------------------------------------------------------------------------------
$(document).ready(function(){
	document.getElementById("ChatSubmit").addEventListener("keypress",function(event){
		if (event["key"] === "Enter"){
			var Message = $("#ChatSubmit").val();
			$.post("http://hud/ChatSubmit",JSON.stringify({ message: Message }));
			$("#ChatBackground").css("background","transparent");
			$("#ChatSubmit").css("display","none");

			if (Message === "" && ChatTime === 0){
				$("#ChatMessage").css("display","none");
			}
		}
	});

	window.addEventListener("message",function(event){
		switch (event["data"]["Action"]){
			case "Progress":
				if ($(".Progress").css("display") === "block"){
					$(".Progress").css("display","none");
					clearInterval(Interval);
					Interval = undefined;

					return
				} else {
					$(".ProgressTimer").html(0 + "%");
					$(".Progress").css("display","block");
					$(".ProgressText").html(event["data"]["Message"]);
				}

				var Percentage = 1;
				Interval = setInterval(Ticker,(event["data"]["Timer"] - 300) / 100);

				function Ticker(){
					Percentage = Percentage + 1;

					if (Percentage >= 100){
						clearInterval(Interval);
						$(".Progress").css("display","none");
						Interval = undefined;
					}

					$(".ProgressTimer").html(Percentage + "%");
				}
			break;

			case "Radio":
				if (event["data"]["Show"] == true){
					if ($("#Radio").css("display") === "none"){
						$("#Radio").show("slide",{ direction: "down" },500);
					}
				} else {
					if ($("#Radio").css("display") === "block"){
						$("#Radio").hide("slide",{ direction: "down" },500);
					}
				}
			break;

			case "Frequency":
				$(".Radio").html(event["data"]["Frequency"]);
			break;

			case "Body":
				if (event["data"]["Status"] == true){
					if ($("#Body").css("display") === "none"){
						$("#Body").fadeIn(1000);
					}
				} else {
					if ($("#Body").css("display") === "block"){
						$("#Body").fadeOut(1000);
					}
				}
			break;

			case "Passport":
				$(".Passport").html(FormatNumber(event["data"]["Number"]));
			break;

			case "Gemstone":
				$(".Gemstone").html(FormatNumber(event["data"]["Number"]));
			break;

			case "Voip":
				if (event["data"]["Voip"] == "Offline"){
					$(".Voip").html("Offline");
				} else {
					if (event["data"]["Voip"] !== "Online"){
						Voip = event["data"]["Voip"];
					}

					$(".Voip").html(Voip);
				}
			break;

			case "Voice":
				$(".Voip").css("color",event["data"]["Status"]);
			break;

			case "Clock":
				var Hours = event["data"]["Hours"];
				var Minutes = event["data"]["Minutes"];

				if (Hours <= 9)
					Hours = "0" + Hours

				if (Minutes <= 9)
					Minutes = "0" + Minutes

				$(".Date").html(Hours + ":" + Minutes);
			break;

			case "Wanted":
				if (event["data"]["Number"] > 0){
					if ($(".Wanted").css("display") === "none"){
						$(".Wanted").fadeIn(1000);
					}

					$(".WantedTimer").html(Minimal(event["data"]["Number"]));
				} else {
					if ($(".Wanted").css("display") === "block"){
						$(".Wanted").fadeOut(1000);
					}
				}
			break;

			case "Reposed":
				if (event["data"]["Number"] > 0){
					if ($(".Reposed").css("display") === "none"){
						$(".Reposed").fadeIn(1000);
					}

					$(".ReposedTimer").html(Minimal(event["data"]["Number"]));
				} else {
					if ($(".Reposed").css("display") === "block"){
						$(".Reposed").fadeOut(1000);
					}
				}
			break;

			case "Road":
				$(".UpStreet").html(event["data"]["Name"]);
			break;

			case "Crossing":
				$(".DownStreet").html(event["data"]["Name"]);
			break;

			case "Health":
				$(".Health").css("stroke-dashoffset",100 - event["data"]["Number"]);
			break;

			case "Armour":
				$(".Armour").css("stroke-dashoffset",100 - event["data"]["Number"]);
			break;

			case "Thirst":
				$(".Thirst").css("stroke-dashoffset",100 - event["data"]["Number"]);
			break;

			case "Hunger":
				$(".Hunger").css("stroke-dashoffset",100 - event["data"]["Number"]);
			break;

			case "Stress":
				$(".Stress").css("stroke-dashoffset",100 - event["data"]["Number"]);
			break;

			case "Luck":
				if (event["data"]["Number"] > 0){
					if ($(".Lucks").css("display") === "none"){
						$(".Lucks").fadeIn(1000);
					}

					event["data"]["Number"] = event["data"]["Number"] / 36;

					$(".Luck").css("stroke-dashoffset",100 - event["data"]["Number"]);
				} else {
					if ($(".Lucks").css("display") === "block"){
						$(".Lucks").fadeOut(1000);
					}
				}
			break;

			case "Dexterity":
				if (event["data"]["Number"] > 0){
					if ($(".Dexteritys").css("display") === "none"){
						$(".Dexteritys").fadeIn(1000);
					}

					event["data"]["Number"] = event["data"]["Number"] / 36;

					$(".Dexterity").css("stroke-dashoffset",100 - event["data"]["Number"]);
				} else {
					if ($(".Dexteritys").css("display") === "block"){
						$(".Dexteritys").fadeOut(1000);
					}
				}
			break;

			case "Doors":
				if (event["data"]["Status"] == true){
					if ($("#Doors").css("display") === "none"){
						$("#Doors").fadeIn(1000);
					}

					$("#Doors > .Text > b").html(event["data"]["Text"]);
				} else {
					if ($("#Doors").css("display") === "block"){
						$("#Doors").fadeOut(1000);
					}
				}
			break;

			case "Vehicle":
				if (event["data"]["Status"] == true){
					if ($("#Vehicle").css("display") === "none"){
						$("#Vehicle").fadeIn(1000);
					}
				} else {
					if ($("#Vehicle").css("display") === "block"){
						$("#Vehicle").fadeOut(1000);
					}
				}
			break;

			case "Fuel":
				var fuelvalue = parseInt(event["data"]["Number"] * 13) / 100
				$(".FuelProgress").css("stroke-dashoffset",(440 - (440 * (13 - fuelvalue)) / 100));
			break;

			case "Speed":
				var Max = 250;
				var Speed = parseInt(event["data"]["Number"]);

				if (Speed > Max)
					Max = event["data"]["Number"];

				var SpeedValue = (Speed * 46) / Max
				$(".SpeedProgress").css("stroke-dashoffset",(440 - (440 * SpeedValue) / 100));

				if (Speed < 10){
					Speed = "00" + Speed
				} else if (Speed >= 10 && Speed < 100){
					Speed = "0" + Speed
				}				

				$(".NumSpeed").html(Speed);
			break;

			case "Rpm":
				var rpmvalue = (event["data"]["Number"] * 18)
				$(".MarchProgress").css("stroke-dashoffset",(440 - (440 * rpmvalue) / 100));
				$(".NumMarch").html(event["data"]["Gear"]);
			break;

			case "Handbrake":
				if (event["data"]["Status"] == false){
					$(".Handbrake").addClass("Gray").removeClass("Red");
				} else {
					$(".Handbrake").addClass("Red").removeClass("Gray");
				}
			break;

			case "Drift":
				if (event["data"]["Status"] == false){
					$(".Drift").addClass("Gray").removeClass("Yellow");
				} else {
					$(".Drift").addClass("Yellow").removeClass("Gray");
				}
			break;

			case "Headlight":
				if (event["data"]["Status"] == 0){
					$(".Headlight").addClass("Gray").removeClass("Green").removeClass("Blue");
				} else {
					if (event["data"]["Beam"] == 0){
						$(".Headlight").addClass("Green").removeClass("Gray").removeClass("Blue");
					} else {
						$(".Headlight").addClass("Blue").removeClass("Gray").removeClass("Green");
					}
				}
			break;

			case "Locked":
				if (event["data"]["Status"] == 2){
					$(".Locked").addClass("Green").removeClass("Gray");
				} else {
					$(".Locked").addClass("Gray").removeClass("Green");
				}
			break;

			case "Tyres":
				if (event["data"]["Number"] == 0){
					$(".Tyres").addClass("Gray").removeClass("Yellow").removeClass("Red");
				} else if (event["data"]["Number"] == 1){
					$(".Tyres").addClass("Yellow").removeClass("Gray").removeClass("Red");
				} else if (event["data"]["Number"] >= 2){
					$(".Tyres").addClass("Red").removeClass("Gray").removeClass("Yellow");
				}
			break;

			case "Nitro":
				event["data"]["Number"] = event["data"]["Number"] / 20
				$(".Nitro").css("stroke-dashoffset",100 - event["data"]["Number"]);
			break;

			case "Notify":
				var Html = `<div id='${"Notify-" + event["data"]["Css"]}'>${event["data"]["Message"]}</div>`;
				$(Html).fadeIn(500).appendTo("#Notify").delay(event["data"]["Timer"]).fadeOut(500);
			break;

			case "Weapons":
				if (event["data"]["Status"] == true){
					if ($("#NaviWeapons").css("display") === "none"){
						$("#NaviWeapons").fadeIn(1000);
					}

					$(".NameWeapon").html(event["data"]["Name"]);
					$(".NameAmmos").html(event["data"]["Min"] + " / " + event["data"]["Max"]);
				} else {
					if ($("#NaviWeapons").css("display") === "block"){
						$("#NaviWeapons").fadeOut(1000);
					}
				}
			break;

			case "Chat":
				if ($("#ChatSubmit").css("display") === "none"){
					$("#ChatSubmit").val("");
					$("#ChatSubmit").css("display","block");
					$("#ChatMessage").css("display","block");
					$("#ChatBackground").css("background","#14141410");

					document.getElementById("ChatSubmit").focus();
					document.getElementById("ChatSubmit").select();
				}
			break;

			case "ChatMessage":
				var Html = `<div>${event["data"]["Author"]}: ${event["data"]["Message"]}</div>`;
				$(Html).appendTo("#ChatMessage");

				if ($("#ChatSubmit").css("display") === "none"){
					var element = document.getElementById("ChatMessage");
					element["scrollTop"] = element["scrollHeight"];

					$("#ChatMessage").css("display","block");
				}

				clearInterval(Chat);
				Chat = undefined;
				ChatTime = 1;

				Chat = setInterval(function(){
					ChatTime = ChatTime + 1;

					if (ChatTime > 5){
						if ($("#ChatSubmit").css("display") === "none"){
							$("#ChatMessage").css("display","none");
						}

						clearInterval(Chat);
						Chat = undefined;
						ChatTime = 0;
					}
				},1000);
			break;

			case "SpawnOpen":
				if ($(".SpawnSelected").css("display") === "none"){
					$(".SpawnSelected").css("display","block");
					$(".SpawnMessage").css("display","block");
				}

				var Characters = event["data"]["Table"].sort((a,b) => (a["Passport"] > b["Passport"]) ? 1 : -1);

				$(".SpawnSelected").html(`
					<div class="SpawnCreateTitle">Personagem</div>
					<div class="SpawnCreateSubtitle">Selecione abaixo o personagem desejado</div>

					${Characters.map((info) => (`
						<div class="SpawnSelectedCharacter" data-passport="${info["Passport"]}">
							<i class="mdi mdi-arrow-up-bold-circle"></i>
							<b>Nome:</b> ${info["Nome"]}<br>
							<b>Sexo:</b> ${info["Sexo"] === "M" ? "Masculino":"Feminino"}<br>
							<b>Banco:</b> $${info["Banco"]}
					</div>`)).join("")}

					<div class="SpawnSelectedNew">+</div>
				`);
			break;

			case "Location":
				if ($(".SpawnLocation").css("display") === "none"){
					$(".SpawnLocation").css("display","block");
				}

				var locate = event["data"]["Table"].sort((a,b) => (a["name"] > b["name"]) ? 1 : -1);

				$(".SpawnLocation").html(`
					${locate.map((info) => (`
						<div class="SpawnLocationBox" data-hash="${info["hash"]}">${info["name"]}</div>
					`)).join("")}

					<div class="SpawnLocationSubmit" data-hash="spawn">Confirmar</div>
				`);
			break;

			case "Textform":
				if (event["data"]["Mode"] === "Create"){
					var html = `<span id=Textform-${event["data"]["Number"]} class="Textform" style="left: 0; top: 0;"></span>`;
					$(html).fadeIn("normal").appendTo("#Textform");
				} else if (event["data"]["Mode"] === "Update"){
					$("#Textform-" + event["data"]["Number"]).css("left",event["data"]["x"] * 100 + "%").css("top",event["data"]["y"] * 100 + "%");
					$("#Textform-" + event["data"]["Number"]).text(event["data"]["Text"])
				} else if (event["data"]["Mode"] === "Remove"){
					$("#Textform-" + event["data"]["Number"]).fadeOut("normal",function(){ $(this).remove(); });
				}
			break;

			case "Request":
				if ($("#Request").css("display") === "none"){
					$("#Request").css("display","block");
				}

				$("#RequestM").html(event["data"]["Message"]);
				$("#RequestY").html(event["data"]["Accept"]);
				$("#RequestU").html(event["data"]["Reject"]);
			break;

			case "Y":
				$("#Request").css("display","none");
				$.post("http://hud/RequestSucess");
			break;

			case "U":
				$("#Request").css("display","none");
				$.post("http://hud/RequestFailure");
			break;

			case "SpawnClose":
				$(".SpawnMessage").css("display","none");
				$(".SpawnCreate").css("display","none");
			break;
		}
	});

	document.onkeyup = function(event){
		switch (event["key"]){
			case "Escape":
				if ($("#Radio").css("display") === "block"){
					$("#Radio").hide("slide",{ direction: "down" },500);
					$.post("http://hud/RadioClose");
				}

				if ($("#ChatSubmit").css("display") === "block"){
					$.post("http://hud/ChatSubmit",JSON.stringify({ message: "" }));
					$("#ChatBackground").css("background","transparent");
					$("#ChatSubmit").css("display","none");
				}
			break;
		}
	}
});
// -------------------------------------------------------------------------------------------
$(document).on("click",".RadioInative",function(){
	$.post("http://hud/RadioInative");
	$(".RadioFrequency").val("");
});
// -------------------------------------------------------------------------------------------
$(document).on("click",".RadioActive",function(){
	var Frequency = parseInt($(".RadioFrequency").val());
	$.post("http://hud/RadioActive",JSON.stringify({ Frequency }));
	$(".RadioFrequency").val("");
});
// -------------------------------------------------------------------------------------------
$(document).on("click",".SpawnSelectedCharacter",function(event){
	$.post("http://hud/CharacterChosen",JSON.stringify({ passport: parseInt(event["currentTarget"]["dataset"]["passport"]) }));
	$(".SpawnSelected").css("display","none");
	$(".SpawnMessage").css("display","none");
});
// -------------------------------------------------------------------------------------------
$(document).on("click",".SpawnLocationBox",function(event){
	$.post("http://hud/Chosen",JSON.stringify({ hash: parseInt(event["currentTarget"]["dataset"]["hash"]) }));
});
// -------------------------------------------------------------------------------------------
$(document).on("click",".SpawnLocationSubmit",function(event){
	$.post("http://hud/Chosen",JSON.stringify({ hash: "spawn" }));
	$(".SpawnLocation").css("display","none");
});
// -------------------------------------------------------------------------------------------
$(document).on("click",".SpawnCreateSubmit",function(event){
	var Nome = $("#SpawnNome").val();
	var Sobrenome = $("#SpawnSobrenome").val();
	var Sexo = $(".SpawnCreate").find(".SpawnCreateButtonActive").attr("id");

	if (Nome != "" && Sobrenome != ""){
		$.post("http://hud/NewCharacter",JSON.stringify({ name: Nome, name2: Sobrenome, sex: Sexo }));
	}
});
// -------------------------------------------------------------------------------------------
$(document).on("click",".SpawnSelectedNew",function(event){
	$(".SpawnSelected").css("display","none");
	$(".SpawnCreate").css("display","block");
});
// -------------------------------------------------------------------------------------------
$(document).on("click",".SpawnCreateCancel",function(event){
	$(".SpawnSelected").css("display","block");
	$(".SpawnCreate").css("display","none");
});
// -------------------------------------------------------------------------------------------
$(document).ready(() => {
	$(".SpawnCreate > button").on("click",function(){
		$(this).parent().find("button").removeClass("SpawnCreateButtonActive");
		$(this).addClass("SpawnCreateButtonActive");
	});
});