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
//= require foundation
//= require turbolinks
//=require jquery.geocomplete
//=require_tree .


function init() {
initMap();
//initSity();
}






//Инициализация карты, поиска городов и изначальная геолокация
$(function(){

    var options = {
        map: ".map_canvas",
        location: 'ru'
    };

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            //Если позиция определена
            (function (pozition) {
                options['location'] = new Array(pozition.coords.latitude, pozition.coords.longitude);
                $("#geocomplete").geocomplete(options);
                    }),
            //Если позиция не определена или возникла ошибка, то выводим карту россии
            (function (err) {
                //TODO доделать отлавливание ошибки
                alert(err.code + ' : ' +err.message);
                $("#geocomplete").geocomplete(options);
            }),
            {enableHighAccuracy:false});
    } else {
        //если браузер не поддерживает геолокацию, то выводим россию
        //TODO доделать обработку неподдерживаемых браузеров
        alert('Вошли сюда22222');
        $("#geocomplete").geocomplete(options);
    };


});

//--------инициализация
//инициализация карты
function  initMap() {
  var myLatlng = new google.maps.LatLng(-34.397, 150.644);
  var myOptions = {
    zoom: 12,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map"), myOptions);
}

