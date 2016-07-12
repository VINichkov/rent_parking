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
//= require turbolinks
//= require bootstrap
//=require_tree .


function init() {
//initMap();
initArea();
}

//--------инициализация
//инициализация карты
function  initMap() {
  setEqualHeight();
  var myLatlng = new google.maps.LatLng(-34.397, 150.644);
  var myOptions = {
    zoom: 12,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map"), myOptions);
}


function initArea() {
  var area = getArea();
  if (area.name === "nil") {
    area = getAreaIP();
  }
    alert('Дошли сюда');
  $('.search-panel span#search_concept').text(area.name);
  $('.search-panel span#search_concept').attr('id_area',area.id);
  viewCity(area.id);
}


//--------конец инициализации
//Изменение размера блока
function setEqualHeight() {
  var myHeight = window.innerHeight;
  var headerHeight= document.getElementById("head").offsetHeight;
  var footerHeight = document.getElementById("fot").offsetHeight;
  var map = document.getElementById("map");
  map.style.height=myHeight-headerHeight-footerHeight+"px";
}

//Элементы выбора
/*
function selectArea(e) {
  $('.search-panel .dropdown-menu').find('a').click(function (e) {
    e.preventDefault();
    var param = $(this).attr("href").replace("#", "");
    var concept = $(this).text();
    var id_area = $(this).attr("id_area");
    viewCity(id_area);
    setArea(id_area);
    $('.search-panel span#search_concept').text(concept);
    $('.search-panel span#search_concept').attr('id_area',id_area);
  });
}
*/
//Обработка событий
//Поиск
/*
+ function ($) {
    $(document).on('click','#search',function(){
      $('.search-panel span#search_concept').text('sdfsdfsd');
    });

}(jQuery);
*/
//Изменение размера окна
/*$(window).resize(function () {
  setEqualHeight();

});
*/
//Выбор области
/*
$(document).ready(function(e) {
  selectArea(e);
});
*/