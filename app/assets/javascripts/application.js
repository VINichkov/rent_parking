// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.js
//= require turbolinks
//=require jquery.geocomplete
//=require_tree .

$(function(){
    autoheight();
    var options = {
        map: ".map_canvas",
        location: 'ru'
    };
    //TODO На время отключил данный блок, чтобы ускорить загрузку
    if (navigator.geolocation ) {
        navigator.geolocation.getCurrentPosition(
            //Если позиция определена
            (function (pozition) {
                //Todo гдето косяк. Работает нестабильно.
                options['location'] = new Array(pozition.coords.latitude, pozition.coords.longitude);
                $("#geocomplete").geocomplete(options);
                    }),
            //Если позиция не определена или возникла ошибка, то выводим карту россии
            (function (err) {
                //TODO доделать отлавливание ошибки
                //alert(err.code + ' : ' +err.message);
                $("#geocomplete").geocomplete(options);
            }),
            {enableHighAccuracy:false, timeout:10000});
    } else {
        //если браузер не поддерживает геолокацию, то выводим россию
        //TODO доделать обработку неподдерживаемых браузеров

        $("#geocomplete").geocomplete(options);
    };

});
//TODO доделать ресайз
$(window).on('resize',autoheight());

//TODO Еще раз проверить функцию
function autoheight() {
 $(".map_canvas").height($(window).height()-$('footer').height()-$('#menu').height());//(-$('footer').style.maxHeight-$('#menu').style.maxHeight);
}
