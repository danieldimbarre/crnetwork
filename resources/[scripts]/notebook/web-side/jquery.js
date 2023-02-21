var Reset = {
    "trackf": 0.0,
    "trackr": 0.0
}

$(document).ready(() => {
    updateSlider();

    $("#defaultbtn").click(function(){
        $.post("http://notebook/reset",JSON.stringify({}),(data) => {
            setSliderValues({
                boost: 0.25,
                curve: 22.5,
                lowspeed: 0.30,
                trafront: 0.48,
                clutchup: 7.0,
                clutchdown: 6.0,
                trackf: data["trackf"],
                trackr: data["trackr"],
                camberf: 0.0,
                camberr: 0.0
            });
        });
    });

    $("#savebtn").click(function(){
        $.post("http://notebook/save",JSON.stringify(getSliderValues()));
    });

    window.addEventListener("message",function(event){
        if (event.data.type == "togglemenu"){
            menuToggle(event.data.state,false);

            if (event.data.data != null){
                Reset["trackf"] = event.data.data[1].trackfReset;
                Reset["trackr"] = event.data.data[1].trackrReset;
                setSliderValues(event.data.data[0]);
            }
        }
    });

    $('input').on('input',function(){
        $(this).parent().find('.text').find('.value').text($(this).val());
    });

    function menuToggle(bool,send = false){
        if (bool){
            $(".display-limiter").fadeIn(500).css('display','flex');
        } else {
            $(".display-limiter").fadeOut(500).css('display','none');
        }

        if (send){
            $.post("http://notebook/togglemenu",JSON.stringify({ state: false }));
        }
    }

    function setSliderValues(values){
        $(".styled-slider").each(function(){
            if (values[this.id] != null) {
                $(this).val(values[this.id]);
            }
        });

        updateSlider();
    }

    function getSliderValues(){
        return {
            boost: $("#boost").val(),
            curve: $("#curve").val(),
            lowspeed: $("#lowspeed").val(),
            trafront: $("#trafront").val(),
            clutchup: $("#clutchup").val(),
            clutchdown: $("#clutchdown").val(),
            trackf: $("#trackf").val(),
            trackr: $("#trackr").val(),
            camberf: $("#camberf").val(),
            camberr: $("#camberr").val(),
        };
    }

    function updateSlider() {
        for (let e of document.querySelectorAll('input[type="range"].slider-progress')){
            e.style.setProperty('--value',e.value);
            if(e.id == "trackf" || e.id == "trackr"){
                e.min = Number(Reset[e.id]) - 0.25;
                e.max = Number(Reset[e.id]) + 0.25;
            }

            e.style.setProperty('--min',e.min == '' ? '0' : e.min);
            e.style.setProperty('--max',e.max == '' ? '100' : e.max);
            e.addEventListener('input',() => e.style.setProperty('--value',e.value));
            $(e).parent().find('.text').find('.value').text($(e).val())
        }
    }

    document.onkeyup = function(data){
        if (data.which == 27){
            menuToggle(false,true);
        }
    };
})