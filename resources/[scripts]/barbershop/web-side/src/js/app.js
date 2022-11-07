$(document).ready(() => {
	var documentWidth = document.documentElement.clientWidth;
    var documentHeight = document.documentElement.clientHeight;

    function triggerClick(x, y) {
        var element = $(document.elementFromPoint(x, y));
        element.focus().click();
        return true;
    }

	window.addEventListener('message',function(event){
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

		$("#beardintensity").parent().parent().parent().find('#minRange').html(event.data.beardintensity);
		document.getElementById("beardintensity").value = event.data.beardintensity;

		$("#beardcolor").attr("max",event.data.maxHaircolors);
		$("#beardcolor").parent().parent().parent().find('#minRange').html(event.data.beardcolor);
		$("#beardcolor").parent().parent().parent().find('#maxRange').html(event.data.maxHaircolors);
		document.getElementById("beardcolor").value = event.data.beardcolor;

		$("#makeup").attr("max",event.data.maxMakeup);
		$("#makeup").parent().parent().parent().find('#minRange').html(event.data.makeup);
		$("#makeup").parent().parent().parent().find('#maxRange').html(event.data.maxMakeup);
		document.getElementById("makeup").value = event.data.makeup;
		
		$("#makeupintensity").parent().parent().parent().find('#minRange').html(event.data.makeupintensity);
		document.getElementById("makeupintensity").value = event.data.makeupintensity;
		
		$("#makeupcolor").attr("max",event.data.maxMakeupcolor);
		$("#makeupcolor").parent().parent().parent().find('#minRange').html(event.data.makeupcolor);
		$("#makeupcolor").parent().parent().parent().find('#maxRange').html(event.data.maxMakeupcolor);
		document.getElementById("makeupcolor").value = event.data.makeupcolor;
		
		$("#blush").attr("max",event.data.maxBlush);
		$("#blush").parent().parent().parent().find('#minRange').html(event.data.blush);
		$("#blush").parent().parent().parent().find('#maxRange').html(event.data.maxBlush);
		document.getElementById("blush").value = event.data.blush;

		$("#blushintensity").parent().parent().parent().find('#minRange').html(event.data.blushintensity);
		document.getElementById("blushintensity").value = event.data.blushintensity;

		$("#blushcolor").attr("max",event.data.maxMakeupcolor);
		$("#blushcolor").parent().parent().parent().find('#minRange').html(event.data.blushcolor);
		$("#blushcolor").parent().parent().parent().find('#maxRange').html(event.data.maxMakeupcolor);
		document.getElementById("blushcolor").value = event.data.blushcolor;
		
		$("#lipstick").attr("max",event.data.maxLipstick);
		$("#lipstick").parent().parent().parent().find('#minRange').html(event.data.lipstick);
		$("#lipstick").parent().parent().parent().find('#maxRange').html(event.data.maxLipstick);
		document.getElementById("lipstick").value = event.data.lipstick;

		$("#lipstickintensity").parent().parent().parent().find('#minRange').html(event.data.lipstickintensity);
		document.getElementById("lipstickintensity").value = event.data.lipstickintensity;

		$("#lipstickcolor").attr("max",event.data.maxMakeupcolor);
		$("#lipstickcolor").parent().parent().parent().find('#minRange').html(event.data.lipstickcolor);
		$("#lipstickcolor").parent().parent().parent().find('#maxRange').html(event.data.maxMakeupcolor);
		document.getElementById("lipstickcolor").value = event.data.lipstickcolor;

		$("#face00").parent().parent().parent().find('#minRange').html(event.data.face00);
		document.getElementById("face00").value = event.data.face00;

		$("#face01").parent().parent().parent().find('#minRange').html(event.data.face01);
		document.getElementById("face01").value = event.data.face01;

		$("#face04").parent().parent().parent().find('#minRange').html(event.data.face04);
		document.getElementById("face04").value = event.data.face04;

		if(event.data.Open == true){
			$("body").fadeIn();
			$(".rangeSlider .slider").each(function( index ) {
				$(this).css({
					'background-image': ('linear-gradient(#12ac5a,#12ac5a)'),
					'backgroundSize': ($(this).val() - $(this).attr('min')) * 100 / ($(this).attr('max') - $(this).attr('min')) + '% 100%'
				});
			});
		}

		if(event.data.Open == false){
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

		$.post('http://barbershop/updateSkin',JSON.stringify({
			value: true,
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
			beardintensity: $('#beardintensity').val(),
			beardcolor: $('#beardcolor').val(),
			blush: $('#blush').val(),
			blushintensity: $('#blushintensity').val(),
			blushcolor: $('#blushcolor').val()
		}));
	});

  	document.onkeydown = function(data){
		if(data.which == 65){
			$.post('http://barbershop/rotate',JSON.stringify("right"));
		}
		if(data.which == 68){
			$.post('http://barbershop/rotate',JSON.stringify("left"));
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

	$.post('http://barbershop/updateSkin',JSON.stringify({
		value: false,
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
		beardintensity: $('#beardintensity').val(),
		beardcolor: $('#beardcolor').val(),
		blush: $('#blush').val(),
		blushintensity: $('#blushintensity').val(),
		blushcolor: $('#blushcolor').val()
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