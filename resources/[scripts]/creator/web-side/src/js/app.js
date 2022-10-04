$(document).ready(() => {
	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;
	var cursorX = documentWidth/2;
	var cursorY = documentHeight/2;
  
  	function triggerClick(x,y){
		var element = $(document.elementFromPoint(x,y));
		element.focus().click();
		return true;
	}
	
	window.addEventListener('message',function(event){
		document.getElementById("fathers").value = event.data.fathers;
		$("#fathers").parent().parent().parent().find('#minRange').html(event.data.fathers);

		document.getElementById("mothers").value = event.data.mothers;
		$("#mothers").parent().parent().parent().find('#minRange').html(event.data.mothers);

		document.getElementById("kinship").value = event.data.kinship;
		$("#kinship").parent().parent().parent().find('#minRange').html(event.data.kinship);

		document.getElementById("eyecolor").value = event.data.eyecolor;
		$("#eyecolor").parent().parent().parent().find('#minRange').html(event.data.eyecolor);

		document.getElementById("skincolor").value = event.data.skincolor;
		$("#skincolor").parent().parent().parent().find('#minRange').html(event.data.skincolor);

		document.getElementById("acne").value = event.data.acne;
		$("#acne").parent().parent().parent().find('#minRange').html(event.data.acne);

		document.getElementById("stains").value = event.data.stains;
		$("#stains").parent().parent().parent().find('#minRange').html(event.data.stains);

		document.getElementById("freckles").value = event.data.freckles;
		$("#freckles").parent().parent().parent().find('#minRange').html(event.data.freckles);

		document.getElementById("aging").value = event.data.aging;
		$("#aging").parent().parent().parent().find('#minRange').html(event.data.aging);

		$("#hair").attr("max",event.data.maxHair);
		$("#hair").parent().parent().parent().find('#minRange').html(event.data.hair);
		$("#hair").parent().parent().parent().find('#maxRange').html(event.data.maxHair);
		document.getElementById("hair").value = event.data.hair;

		$("#haircolor").attr("max",event.data.maxHaircolors);
		$("#haircolor").parent().parent().parent().find('#minRange').html(event.data.haircolor);
		$("#haircolor").parent().parent().parent().find('#maxRange').html(event.data.maxHaircolors);
		document.getElementById("haircolor").value = event.data.haircolor;

		$("#haircolor2").attr("max",event.data.maxHaircolors);
		$("#haircolor2").parent().parent().parent().find('#minRange').html(event.data.haircolor2);
		$("#haircolor2").parent().parent().parent().find('#maxRange').html(event.data.maxHaircolors);
		document.getElementById("haircolor2").value = event.data.haircolor2;

		$("#eyebrow").attr("max",event.data.maxEyebrow);
		$("#eyebrow").parent().parent().parent().find('#minRange').html(event.data.eyebrow);
		$("#eyebrow").parent().parent().parent().find('#maxRange').html(event.data.maxEyebrow);
		document.getElementById("eyebrow").value = event.data.eyebrow;

		$("#eyebrowintensity").parent().parent().parent().find('#minRange').html(event.data.eyebrowintensity);
		document.getElementById("eyebrowintensity").value = event.data.eyebrowintensity;

		$("#eyebrowcolor").attr("max",event.data.maxHaircolors);
		$("#eyebrowcolor").parent().parent().parent().find('#minRange').html(event.data.eyebrowcolor);
		$("#eyebrowcolor").parent().parent().parent().find('#maxRange').html(event.data.maxHaircolors);
		document.getElementById("eyebrowcolor").value = event.data.eyebrowcolor;

		$("#beard").attr("max",event.data.maxBeard);
		$("#beard").parent().parent().parent().find('#minRange').html(event.data.beard);
		$("#beard").parent().parent().parent().find('#maxRange').html(event.data.maxBeard);
		document.getElementById("beard").value = event.data.beard;

		$("#beardintentisy").parent().parent().parent().find('#minRange').html(event.data.beardintentisy);
		document.getElementById("beardintentisy").value = event.data.beardintentisy;

		$("#beardcolor").attr("max",event.data.maxHaircolors);
		$("#beardcolor").parent().parent().parent().find('#minRange').html(event.data.beardcolor);
		$("#beardcolor").parent().parent().parent().find('#maxRange').html(event.data.maxHaircolors);
		document.getElementById("beardcolor").value = event.data.beardcolor;

		$("#makeup").attr("max",event.data.maxMakeup);
		$("#makeup").parent().parent().parent().find('#minRange').html(event.data.maxMakeup);
		$("#makeup").parent().parent().parent().find('#maxRange').html(event.data.maxMakeup);
		document.getElementById("makeup").value = event.data.makeup;
		
		$("#makeupintensity").parent().parent().parent().find('#minRange').html(event.data.makeupintensity);
		document.getElementById("makeupintensity").value = event.data.makeupintensity;
		
		$("#makeupcolor").attr("max",event.data.maxMakeupcolor);
		$("#makeupcolor").parent().parent().parent().find('#minRange').html(event.data.maxMakeupcolor);
		$("#makeupcolor").parent().parent().parent().find('#maxRange').html(event.data.maxMakeupcolor);
		document.getElementById("makeupcolor").value = event.data.makeupcolor;
		
		$("#blush").attr("max",event.data.maxBlush);
		$("#blush").parent().parent().parent().find('#minRange').html(event.data.maxBlush);
		$("#blush").parent().parent().parent().find('#maxRange').html(event.data.maxBlush);
		document.getElementById("blush").value = event.data.blush;

		$("#blushintentisy").parent().parent().parent().find('#minRange').html(event.data.blushintentisy);
		document.getElementById("blushintentisy").value = event.data.blushintentisy;

		$("#blushcolor").attr("max",event.data.maxMakeupcolor);
		$("#blushcolor").parent().parent().parent().find('#minRange').html(event.data.maxMakeupcolor);
		$("#blushcolor").parent().parent().parent().find('#maxRange').html(event.data.maxMakeupcolor);
		document.getElementById("blushcolor").value = event.data.blushcolor;
		
		$("#lipstick").attr("max",event.data.maxLipstick);
		$("#lipstick").parent().parent().parent().find('#minRange').html(event.data.maxLipstick);
		$("#lipstick").parent().parent().parent().find('#maxRange').html(event.data.maxLipstick);
		document.getElementById("lipstick").value = event.data.lipstick;

		$("#lipstickintensity").parent().parent().parent().find('#minRange').html(event.data.lipstickintensity);
		document.getElementById("lipstickintensity").value = event.data.lipstickintensity;

		$("#lipstickcolor").attr("max",event.data.maxMakeupcolor);
		$("#lipstickcolor").parent().parent().parent().find('#minRange').html(event.data.maxMakeupcolor);
		$("#lipstickcolor").parent().parent().parent().find('#maxRange').html(event.data.maxMakeupcolor);
		document.getElementById("lipstickcolor").value = event.data.lipstickcolor;
		
		$("#face00").parent().parent().parent().find('#minRange').html(event.data.face00);
		document.getElementById("face00").value = event.data.face00;

		$("#face01").parent().parent().parent().find('#minRange').html(event.data.face01);
		document.getElementById("face01").value = event.data.face01;

		$("#face04").parent().parent().parent().find('#minRange').html(event.data.face04);
		document.getElementById("face04").value = event.data.face04;

		$("#face06").parent().parent().parent().find('#minRange').html(event.data.face06);
		document.getElementById("face06").value = event.data.face06;

		$("#face08").parent().parent().parent().find('#minRange').html(event.data.face08);
		document.getElementById("face08").value = event.data.face08;

		$("#face09").parent().parent().parent().find('#minRange').html(event.data.face09);
		document.getElementById("face09").value = event.data.face09;

		$("#face10").parent().parent().parent().find('#minRange').html(event.data.face10);
		document.getElementById("face10").value = event.data.face10;

		$("#face12").parent().parent().parent().find('#minRange').html(event.data.face12);
		document.getElementById("face12").value = event.data.face12;

		$("#face13").parent().parent().parent().find('#minRange').html(event.data.face13);
		document.getElementById("face13").value = event.data.face13;

		$("#face14").parent().parent().parent().find('#minRange').html(event.data.face14);
		document.getElementById("face14").value = event.data.face14;

		$("#face15").parent().parent().parent().find('#minRange').html(event.data.face15);
		document.getElementById("face15").value = event.data.face15;

		$("#face16").parent().parent().parent().find('#minRange').html(event.data.face16);
		document.getElementById("face16").value = event.data.face16;

		$("#face17").parent().parent().parent().find('#minRange').html(event.data.face17);
		document.getElementById("face17").value = event.data.face17;

		$("#face19").parent().parent().parent().find('#minRange').html(event.data.face19);
		document.getElementById("face19").value = event.data.face19;

		if(event.data.openCreator == true){
			$("body").fadeIn();
			$(".rangeSlider .slider").each(function( index ) {
				$(this).css({
					'background-image': ('linear-gradient(#12ac5a,#12ac5a)'),
					'backgroundSize': ($(this).val() - $(this).attr('min')) * 100 / ($(this).attr('max') - $(this).attr('min')) + '% 100%'
				});
			});
		}

		if(event.data.openCreator == false){
			$("body").fadeOut();
		}
	});

  	$('.leftC .sectionCategorys .option').on('click', function () {
		let iconImage = $(this).find('img').attr('src');
		$('.leftC .sectionCategorys .option').removeClass('active');
		$(this).addClass('active');
		$('.leftC .sectionContent').hide();
		$('#'+$(this).attr('data-index')).show();

		$('.leftC #categoryName').html($(this).attr('data-index'));
		$('.leftC .sectionContent .item .icon').find('img').attr('src', iconImage)
  	});
	
  	$('.rightC .sectionCategorys .option').on('click', function () {
		let iconImage = $(this).find('img').attr('src');
		$('.rightC .sectionCategorys .option').removeClass('active');
		$(this).addClass('active');
		$('.rightC .sectionContent').hide();
		$('#'+$(this).attr('data-index')).show();

		$('.rightC #categoryName').html($(this).attr('data-index'));
		$('.rightC .sectionContent .item .icon').find('img').attr('src', iconImage)
  	});

  	$('.done-btn').on('click',function(e){
		e.preventDefault();

		$.post('http://creator/updateSkin',JSON.stringify({
			value: true,
			fathers: $('#fathers').val(),
			mothers: $('#mothers').val(),
			kinship: $('#kinship').val(),
			eyecolor: $('#eyecolor').val(),
			skincolor: $('#skincolor').val(),
			acne: $('#acne').val(),
			stains: $('#stains').val(),
			freckles: $('#freckles').val(),
			aging: $('#aging').val(),
			hair: $('#hair').val(),
			haircolor: $('#haircolor').val(),
			haircolor2: $('#haircolor2').val(),
			makeup: $('#makeup').val(),
			makeupintensity: $('#makeupintensity').val(),
			makeupcolor: $('#makeupcolor').val(),
			lipstick: $('#lipstick').val(),
			lipstickintensity: $('#lipstickintensity').val(),
			lipstickcolor: $('#lipstickcolor').val(),
			eyebrow: $('#eyebrow').val(),
			eyebrowintensity: $('#eyebrowintensity').val(),
			eyebrowcolor: $('#eyebrowcolor').val(),
			beard: $('#beard').val(),
			beardintentisy: $('#beardintentisy').val(),
			beardcolor: $('#beardcolor').val(),
			blush: $('#blush').val(),
			blushintentisy: $('#blushintentisy').val(),
			blushcolor: $('#blushcolor').val(),
			face00: $('#face00').val(),
			face01: $('#face01').val(),
			face04: $('#face04').val(),
			face06: $('#face06').val(),
			face08: $('#face08').val(),
			face09: $('#face09').val(),
			face10: $('#face10').val(),
			face12: $('#face12').val(),
			face13: $('#face13').val(),
			face14: $('#face14').val(),
			face15: $('#face15').val(),
			face16: $('#face16').val(),
			face17: $('#face17').val(),
			face19: $('#face19').val()
		}));
	});

  	document.onkeydown = function(data){
		if(data.which == 65){
			$.post('http://creator/rotate',JSON.stringify("right"));
		}
		if(data.which == 68){
			$.post('http://creator/rotate',JSON.stringify("left"));
		}
	}
})


function change(e) {
	let min = $(e).attr('min'),
	max = $(e).attr('max'),
	val = $(e).val();

	$(e).css({
		'background-image': ('linear-gradient(#00ff77,#00ff77)'),
		'backgroundSize': (val - min) * 100 / (max - min) + '% 100%'
	});

	$.post('http://creator/updateSkin',JSON.stringify({
		value: false,
		fathers: $('#fathers').val(),
		mothers: $('#mothers').val(),
		kinship: $('#kinship').val(),
		eyecolor: $('#eyecolor').val(),
		skincolor: $('#skincolor').val(),
		acne: $('#acne').val(),
		stains: $('#stains').val(),
		freckles: $('#freckles').val(),
		aging: $('#aging').val(),
		hair: $('#hair').val(),
		haircolor: $('#haircolor').val(),
		haircolor2: $('#haircolor2').val(),
		makeup: $('#makeup').val(),
		makeupintensity: $('#makeupintensity').val(),
		makeupcolor: $('#makeupcolor').val(),
		lipstick: $('#lipstick').val(),
		lipstickintensity: $('#lipstickintensity').val(),
		lipstickcolor: $('#lipstickcolor').val(),
		eyebrow: $('#eyebrow').val(),
		eyebrowintensity: $('#eyebrowintensity').val(),
		eyebrowcolor: $('#eyebrowcolor').val(),
		beard: $('#beard').val(),
		beardintentisy: $('#beardintentisy').val(),
		beardcolor: $('#beardcolor').val(),
		blush: $('#blush').val(),
		blushintentisy: $('#blushintentisy').val(),
		blushcolor: $('#blushcolor').val(),
		face00: $('#face00').val(),
		face01: $('#face01').val(),
		face04: $('#face04').val(),
		face06: $('#face06').val(),
		face08: $('#face08').val(),
		face09: $('#face09').val(),
		face10: $('#face10').val(),
		face12: $('#face12').val(),
		face13: $('#face13').val(),
		face14: $('#face14').val(),
		face15: $('#face15').val(),
		face16: $('#face16').val(),
		face17: $('#face17').val(),
		face19: $('#face19').val()
	}));
	
	$(e).parent().parent().parent().find('#minRange').html($(e).val());
}

function nextRange(e) {
	let currentValue = parseInt($(e).prev().find('input').val());
	$(e).prev().find('input').val(currentValue+=1)
	change($(e).prev().find('input'));
}

function prevRange(e) {
	let currentValue = $(e).next().find('input').val();
	$(e).next().find('input').val(currentValue-=1)
	change($(e).next().find('input'));
}