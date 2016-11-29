# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require bootstrap.js
#= require turbolinks
#= require gmaps
#= require react
#= require react_ujs
#= require fileinput.js
#=require 'locales/ru.js'
#= require_tree ./components
#=require_tree .

#New parking\Edit parking
#Create map
console.log(React)
console.log(ReactDOM)

$(->
  $(document).on('page:change',->

#Обработка на страницах редактирования парковки
    if $('#map_edit')[0]!=undefined

      lat =$('#lat')
      lng =$('#lan')
      mark = null

      if lat.val()=='' and  lng.val() == ''
        lat.val(54.9889599)
        lng.val(73.3678863)
        GMaps.geolocate(
          success: (position)->
            lat.val(position.coords.latitude)
            lng.val(position.coords.longitude)
            map.setCenter(lat.val(),lng.val())
            if mark != null
              map.removeMarker(mark)
            mark = map.addMarker(lat: lat.val(),lng: lng.val())
          ,
          error: (error)->
            alert('Определить местоположение не удалось. Пожалуйста введите адрес')
          ,
          not_supported: ->
            alert("Your browser does not support geolocation")
        )


      map=new GMaps(
        div: '#map_edit',
        zoom: 16,
        lat: Number(lat.val()),
        lng: Number(lng.val())
        dragend: (e)->
          if mark != null
            map.removeMarker(mark)
          mark = map.addMarker(lat: e.center.lat(), lng: e.center.lng())
          lat.val(e.center.lat())
          lng.val(e.center.lng())

      )


      if mark != null
        map.removeMarker(mark)
      mark = map.addMarker(lat: Number(lat.val()), lng: Number(lng.val()))

      $("#search-adr").click ->
        GMaps.geocode(
          address: $("#addres").val(),
          callback: (results, status)->
            if status=='OK'
              latlng = results[0].geometry.location
              map.setCenter(latlng.lat(), latlng.lng())
              if mark != null
                map.removeMarker(mark)
              mark = map.addMarker(lat: latlng.lat(), lng: latlng.lng())
              lat.val(latlng.lat())
              lng.val(latlng.lng())

        )

    #обработка на первой странице
    if $('#map_canvas')[0]!=undefined
      autoheight()
      glan=glng=null
      if glan==null or glng==null
        glan=54.9889599
        glng=73.3678863
        GMaps.geolocate(
          success: (position)->
            glan=position.coords.latitude
            glng=position.coords.longitude
            map.setCenter(lat.val(),lng.val())
          ,
          error: (error)->
            alert('Определить местоположение не удалось. Пожалуйста введите адрес')
          ,
          not_supported: ->
            alert("Your browser does not support geolocation")
        )

      general_map = GMaps(
        div: '#map_canvas',
        zoom: 16,
        lat: Number(glan),
        lng: Number(glng)
      )
      $.ajax(
        url: '/parkings/index_json.json',
        success: (rez)->
          general_map.addMarkers(rez)
      )

      $(window).on('resize',autoheight)

  )
)


#TODO Еще раз проверить функцию
autoheight=()->
    $("#map_canvas").height($(window).height()-$('footer').height()-$('#menu').height())#(-$('footer').style.maxHeight-$('#menu').style.maxHeight)

#Расширения bootstrap
$(->
  $('[data-toggle="tooltip"]').tooltip()

  #Загрузка картинок на сервер
  $("#parking_image").fileinput({
    language: "ru",
    uploadAsync:false,
    maxFileCount:15,
    #uploadUrl: "/patchphotos",
    allowedFileExtensions: ["jpg", "png", "gif"]
 })
)

#$(->
##Вызов компонента рекат. Пока будет здесь
#  ReactDOM.render(React.createElement(Fileinput),$('#react')[0]);
#)

