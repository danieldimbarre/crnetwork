var SelectPage = "Prender";
var ReversePage = "Prender";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	functionPrender();

	window.addEventListener("message",function(Event){
		switch (Event["Data"]["Action"]){
			case "openSystem":
				$("#mainPage").css("display","block");
			break;

			case "closeSystem":
				$("#mainPage").css("display","none");
			break;

			case "reloadPrison":
				functionPrender();
			break;

			case "reloadFine":
				functionMultar();
			break;

			case "reloadSearch":
				functionSearch(Event["Data"]["Data"]);
			break;
		};
	});

	document.onkeyup = function(Data){
		if (Data["which"] == 27){
			$.post("http://police/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).on("click","#mainMenu li",function(){
	if (SelectPage != ReversePage){
		let isActive = $(this).hasClass('active');
		$('#mainMenu li').removeClass('active');
		if (!isActive){
			$(this).addClass('active');
			ReversePage = SelectPage;

			$("#content").css("height","414px");
			$("#content").css("margin","76px 30px 30px 30px");
		};
	};
});
/* ----------FUNCTIONSEARCH---------- */
const functionSearch = (Passport) => {
	if (Passport != ""){
		$.post("http://police/searchUser",JSON.stringify({ Passport: parseInt(Passport) }),(Data) => {
			if(Data["result"][0] == true){
				$('#content').html(`
					<div id="titleContent">${Data["result"][1]}</div>
					<div id="pageLeftSearch">
						<div class="searchBox">
							<b>Passaporte:</b> ${formatarNumero(Passport)}<br>
							<b>Nome:</b> ${Data["result"][1]}<br>
							<b>Telefone:</b> ${Data["result"][2]}<br>
							<b>Multas:</b> $${formatarNumero(Data["result"][3])}<br>
						</div>

						${Data["result"][4].map((Data) => (`
							<div class="recordBox">
								<div class="fineSeachTitle">
									<span style="width: 250px; float: left;"><b>Policial:</b> ${Data["police"]}</span>
									<span style="width: 125px; float: left;"><b>Serviços:</b> ${formatarNumero(Data["services"])}</span>
									<span style="width: 110px; float: left;"><b>Multa:</b> $${formatarNumero(Data["fines"])}</span>
									<span style="width: 150px; float: right; text-align: right;">${Data["date"]}</span>
								</div>
								${Data["text"]}
							</div>
						`)).join('')}
					</div>

					<div id="pageRight">
						<h2>OBSERVAÇÕES:</h2>
						<b>1:</b> Todas as informações encontradas são de uso exclusivo policial, tudo que for encontrado na mesma são informações em tempo real.<br><br>
						<b>2:</b> Nunca forneça qualquer informação dessa página para outra pessoa, apenas se a mesma for o proprietário ou o advogado do mesmo.
					</div>
				`);
			} else {
				$('#content').html(`
					<div id="titleContent">RESULTADO</div>
					Não foi encontrado informações sobre o Passport procurado.
				`);
			}
		});
	}
}
/* ----------BUTTONSEARCH---------- */
$(document).on("click",".buttonSearch",function(e){
	const Passport = $('#searchPassaporte').val();
	functionSearch(Passport);
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionPrender = () => {
	SelectPage = "Prender";

	$('#content').html(`
		<div id="titleContent">PRENDER</div>
		<div id="pageLeft">
			<input class="inputPrison" id="prenderPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputPrison" id="prenderServices" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Serviços."></input>
			<input class="inputPrison2" id="prenderMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			<textarea class="textareaPrison" maxlength="500" id="prenderTexto" value="" placeholder="Todas as informações dos crimes."></textarea>
			<button class="buttonPrison">Prender</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com o crime efetuado, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
			<b>3:</b> Todas as prisões são salvas no sistema após o envio, então lembre-se que cada formulário enviado, o valor das multas, serviços e afins são somados com a ultima prisão caso o mesmo ainda esteja preso.
		</div>
	`);
};
/* ----------BUTTONPRISON---------- */
$(document).on("click",".buttonPrison",function(e){
	const Passport = $('#prenderPassaporte').val()
	const Services = $('#prenderServices').val()
	const Fines = $('#prenderMultas').val()
	const Text = $('#prenderTexto').val()

	if (Passport != "" && Services != "" && Fines != "" && Text != ""){
		$.post("http://police/initPrison",JSON.stringify({
			Passport: parseInt(Passport),
			Services: parseInt(Services),
			Fines: parseInt(Fines),
			Text: Text
		}));
	}
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionMultar = () => {
	SelectPage = "Multar";

	$('#content').html(`
		<div id="titleContent">MULTAR</div>
		<div id="pageLeft">
			<input class="inputFine" id="multarPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<input class="inputFine2" id="multarMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa."></input>
			<textarea class="textareaFine" id="multarTexto" maxlength="500" value="" placeholder="Todas as informações da multa."></textarea>
			<button class="buttonFine">Multar</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com a multa, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
			<b>2:</b> Ao preencher o campo de Fines, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.<br><br>
		</div>
	`);
};
/* ----------BUTTONFINE---------- */
$(document).on("click",".buttonFine",function(e){
	const Passport = $('#multarPassaporte').val()
	const Fines = $('#multarMultas').val()
	const Text = $('#multarTexto').val()

	if (Passport != "" != "" && Fines != "" && Text != ""){
		$.post("http://police/initFine",JSON.stringify({
			Passport: parseInt(Passport),
			Fines: parseInt(Fines),
			Text: Text
		}));
	}
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