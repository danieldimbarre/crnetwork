var Max = 0;
var Checkpoint = 0;
// -------------------------------------------------------------------------------------------
function MinimalTimers(Seconds){
	var Seconds = parseInt(Seconds / 1000)
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
	} else {
		return "00:00"
	}
}
// -------------------------------------------------------------------------------------------
$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch (event["data"]["Action"]){
			case "Display":
				if (event["data"]["Status"] == true){
					if ($("#Scoreboard").css("display") === "none"){
						$("#Scoreboard").css("display","block");
						Max = event["data"]["Max"];
						Checkpoint = 1;
					}
				} else {
					if ($("#Scoreboard").css("display") === "block"){
						$("#Scoreboard").css("display","none");
					}
				}
			break;

			case "Checkpoint":
				Checkpoint = Checkpoint + 1;
			break;

			case "Ranking":
				if (event["data"]["Status"] == true){
					if ($("#Ranking").css("display") === "none"){
						var Result = event["data"]["Ranking"];

						if (Result !== "[]"){
							$("#Ranking").css("display","block");

							var position = 0;
							$("#Ranking").html("");
							$("#Ranking").html(`
								<div id="raceTitle">RANKING</div>
								<div id="raceLegend">Lista dos 5 melhores colocados neste circuito.</div>
								`);

							$("#Ranking").css("display","block");

							$.each(JSON.parse(Result),(k,v) => {
								$('#Ranking').append(`
									<div id="raceLine">
										<div class="racePosition">${position = position + 1}</div>
										<div class="raceName">${v["name"]}</div>
										<div class="raceVehicle">${v["vehicle"]}</div>
										<div class="racePoints">${MinimalTimers(v["points"])}</div>
									</div>
								`);
							});

							$('#Ranking').append(`<div id="raceButtom">Pressionando a tecla <key>G</key> você fecha o ranking</div>`);
							$("#Ranking").css("display","block");
						}
					}
				} else {
					if ($("#Ranking").css("display") === "block"){
						$("#Ranking").css("display","none");
					}
				}
			break;

			case "Progress":
				$("#Scoreboard").html(`
					CHECKPOINTS <s>${Checkpoint} / ${Max}</s><br>
					PERCORRIDO <s>${MinimalTimers(event["data"]["Points"])}</s><br>
					TEMPO <s>${MinimalTimers(event["data"]["Timer"])}</s>
				`);
			break;
		}
	});
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}