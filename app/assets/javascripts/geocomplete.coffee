#Перевод компонента на coffee

(($, window, document) ->
#Параметры по умолчанию
# * `map` - jQuery селектор или DOM объект. По умолчанию `false`
# * `details` - Контейнер, который должен быть запонен данными. По умолчанию `false`. По умолчанию игнорируется
# * 'detailsScope' - Allows you to scope the 'details' container and have multiple geocomplete fields on one page. Must be a parent of the input. Default is 'null'
# * `location` - Локация для инициализации карты. Может быть адресом `string` или  масством вида [latitude, longitude] c координатами или объектом `google.maps.LatLng`. По умолчанию `false`  показывает пустую карту. Необходимо переопределить
# * `bounds` - Whether to snap geocode search to map bounds. Default: `true` if false search globally. Alternatively pass a custom `LatLngBounds object.
# * `autoselect` - Automatically selects the highlighted item or the first item from the suggestions list on Enter.
# * `detailsAttribute` - The attribute's name to use as an indicator. Default: `"name"`
# * `mapOptions` - Options to pass to the `google.maps.Map` constructor. See the full list [here](http://code.google.com/apis/maps/documentation/javascript/reference.html#MapOptions).
# * `mapOptions.zoom` - The inital zoom level. Default: `14`
# * `mapOptions.scrollwheel` - Whether to enable the scrollwheel to zoom the map. Default: `false`
# * `mapOptions.mapTypeId` - The map type. Default: `"roadmap"`
# * `markerOptions` - The options to pass to the `google.maps.Marker` constructor. See the full list [here](http://code.google.com/apis/maps/documentation/javascript/reference.html#MarkerOptions).
# * `markerOptions.draggable` - If the marker is draggable. Default: `false`. Set to true to enable dragging.
# * `markerOptions.disabled` - Do not show marker. Default: `false`. Set to true to disable marker.
# * `maxZoom` - The maximum zoom level too zoom in after a geocoding response. Default: `16`
# * `types` - An array containing one or more of the supported types for the places request. Default: `['geocode']` See the full list [here](http://code.google.com/apis/maps/documentation/javascript/places.html#place_search_requests).
# * `blur` - Trigger geocode when input loses focus.
# * `geocodeAfterResult` - If blur is set to true, choose whether to geocode if user has explicitly selected a result before blur.
# * `restoreValueAfterBlur` - Restores the input's value upon blurring. Default is `false` which ignores the setting.
  defaults =
    bounds: true
    country: null
    map: false
    details: false
    detailsAttribute: "name"
    detailsScope: null
    autoselect: true
    location: false

    mapOptions:
      zoom: 14
      scrollwheel: false
      mapTypeId: "roadmap"


    markerOptions:
      draggable: false


    maxZoom: 16
    types: ['geocode']
    blur: false
    geocodeAfterResult: false
    restoreValueAfterBlur: false

  # Смотри: [Geocoding Types](https://developers.google.com/maps/documentation/geocoding/#Types)
  # на  Google Developers.
  componentTypes = "street_address route intersection political " +
    "country administrative_area_level_1 administrative_area_level_2 " +
    "administrative_area_level_3 colloquial_area locality sublocality " +
    "neighborhood premise subpremise postal_code natural_feature airport " +
    "park point_of_interest post_box street_number floor room " +
    "lat lng viewport location " +
    "formatted_address location_type bounds".split(" ")

  # Смотри: [Places Details Responses](https://developers.google.com/maps/documentation/javascript/places#place_details_responses)
  # на Google Developers.
  placesDetails = "id place_id url website vicinity reference name rating " +
  "international_phone_number icon formatted_phone_number".split(" ")

  #Конструктор плагина
  GeoComplete =(input, options) ->
    #Если заданы параметры в options, то используем их. Иначе берем умолчательные
    @options = $.extend(true, {}, defaults, options)

    # This is a fix to allow types:[] not to be overridden by defaults
    # so search results includes everything
    if (options && options.types)
      @options.types = options.types


    @input = input
    @$input = $(input)

    @_defaults = defaults
    @_name = 'geocomplete'
  
    @init()
  
  #Делаем плагин доступным и инициализируем при загрузке  
  $.extend(GeoComplete.prototype,
    init:  ->
      @initMap()
      @initMarker()
      @initGeocoder()
      @initDetails()
      @initLocation()

    # Инициализация карты, но только если задан map.
    # Это будет создавать карту в заданном контейнере
    # используется `mapOptions` или ссылка на объект.
    initMap:  ->
      if (!@options.map)
        return

      if (typeof this.options.map.setCenter == "function")
        this.map = this.options.map


      #Создаем объект карты и помещаем его в переменную map
      @map = new (google.maps.Map)($(@options.map)[0],@options.mapOptions)

      #Добавляем просшушку события клика по карте. Нет самого действия
      #noinspection JSUnresolvedVariable
      google.maps.event.addListener(@map,'click',$.proxy(@mapClicked, this))
      #Добавить прослушку события конец перетаскивания
      #noinspection JSUnresolvedVariable
      google.maps.event.addListener(@map,'dragend',$.proxy(@mapDragged, this))
      #Добавление прослушки события режима ожидания
      #noinspection JSUnresolvedVariable
      google.maps.event.addListener(@map,'idle',$.proxy(@mapIdle, this))
      #Добавление прослушки события изменения зума
      #noinspection JSUnresolvedVariable
      google.maps.event.addListener(@map,'zoom_changed',$.proxy(@mapZoomed, this))


    #Добавление маркера с библиотекой`markerOptions`, но только
    #если опции были заданы. Дополнительно прослушка собылия окончания перетаскивания
    #для сообщение плагину
    initMarker: ->
      if (!@map)
        return
      options = $.extend(@options.markerOptions, { map: @map });

      if (options.disabled)
        return
      @marker = new google.maps.Marker(options)
      #Добавить прослушку события конец перетаскивания
      google.maps.event.addListener(@marker,'dragend',$.proxy(@markerDragged, this))


    #Ассоциация добавления с автозаполнением и созданием геокодера
    #откат, когда автозаполнение не возвращает значение
    initGeocoder: ->
    #Указывает что пользователь выбрал результат из выпадающего списка
      selected = false

      options =
        types: @options.types,
        bounds: @options.bounds == true ? null : @options.bounds,
        componentRestrictions: @options.componentRestrictions

      if (@options.country)
        options.componentRestrictions =
          country: @options.country

      @autocomplete = new google.maps.places.Autocomplete(@input, options)
      @geocoder = new google.maps.Geocoder()

      #Привязать автокомплейт к карте, но только если есть карта
      #и `options.bindToMap` если еcть bindToMap
      if (@map && @options.bounds == true)
        @autocomplete.bindTo('bounds', @map);

      #Смотреть `place_changed`  события на элементе ввода автозаполнения.
      google.maps.event.addListener(@autocomplete,'place_changed',$.proxy(@placeChanged, this)
      #Предотвратить появление радительской формы, если пользователь нажал кнопку ввода
      @$input.on('keypress.' + @_name, (event)->
        if (event.keyCode == 13)
          false
      )
      #Предположим, что если пользователь введет что-либо после выбора результата,
      #то ничего не произойдет
      if (@options.geocodeAfterResult == true)
        @$input.bind('keypress.' + this._name, $.proxy(->
          if (event.keyCode != 9 && @selected == true)
            @selected = false
        , this))

      #Прослушиваем "geocode" событие и триггер найденного действия.
      @$input.bind('geocode.' + @_name, $.proxy(->
        @find()
      , this))

      #Сохранение предыдущего введенного значения
      @$input.bind('geocode:result.' + @_name, $.proxy(->
        @lastInputVal = @$input.val()
      , this))

      #Тригер найденых действий когда введенный элемент  не точен и пользователь имеет
      #не явный выбор везультата
      #(Полезно для частичного ввода и перехода табуляцией к следующему полю
      #или клик на каком либо элементе)
      if (@options.blur == true)
        @$input.on('blur.' + @_name, $.proxy(->
          if (@options.geocodeAfterResult == true && @selected == true)
             return)
          if (@options.restoreValueAfterBlur == true && @selected == true)
            setTimeout($.proxy(@restoreLastValue, this), 0)
          else
            this.find()
        , this))
          
    #Подготовка полученной DOM структуры для записи при получении данных.
    #Он будет двигаться по списку компонентов и карте
    #соответствующего элемента.
    initDetails: ->
      if (!@options.details)
        return

      if(@options.detailsScope)
        $details = $(@input).parents(@options.detailsScope).find(@options.details)
      else
        $details = $(@options.details)

      attribute = @options.detailsAttribute
      details = {}

      setDetail=(value)->
        details[value] = $details.find("[" +  attribute + "=" + value + "]")

      $.each(componentTypes, (index, key)->
        setDetail(key)
        setDetail(key + "_short")
      )

      $.each(placesDetails, (index, key)->
        setDetail(key)
      )

      @$details = $details
      @details = details

    #Инициализация локации в плагине при заданных опциях
    #Этот метод делает конвертацию значения в правильный формат
    initLocation: ->
      location = @options.location
      latLng

      if (!location)
        return

      if (typeof location == 'string')
        @find(location)
        return


      if (location instanceof Array)
        latLng = new google.maps.LatLng(location[0], location[1])


      if (location instanceof google.maps.LatLng)
        latLng = location

      if (latLng)
        if (@map)
          @map.setCenter(latLng)
        if (@marker)
          @marker.setPosition(latLng)

    destroy: ->
      if (this.map)
        google.maps.event.clearInstanceListeners(@map)
        google.maps.event.clearInstanceListeners(@marker)

      @autocomplete.unbindAll();
      google.maps.event.clearInstanceListeners(@autocomplete);
      google.maps.event.clearInstanceListeners(@input);
      @$input.removeData();
      @$input.off(@_name);
      @$input.unbind('.' + @_name)

    #Посмотри на указанный адрес. Если не был указан адрес, он используется
    #текущим значением для ввода
        find: (address)->
          @geocode(address: address || @$input.val())

    #TODo допереводить комментарии
    #Requests details about a given location.
    # Additionally it will bias the requests to the provided bounds.
    geocode: (request)->
    #Don't geocode if the requested address is empty
      if (!request.address)
        return
      if (@options.bounds && !request.bounds)
        if (@options.bounds == true)
          request.bounds = @map && @map.getBounds()
        else
          request.bounds = @options.bounds

      if (@options.country)
        request.region = @options.country

      @geocoder.geocode(request, $.proxy(@handleGeocode, this))

    #Get the selected result. If no result is selected on the list, then get
    #the first result from the list.
    selectFirstResult: ->
      #$(".pac-container").hide();
      selected = ''
      #Check if any result is selected.
      if ($(".pac-item-selected")[0])
        selected = '-selected'

      #Get the first suggestion's text.
      $span1 = $(".pac-container:visible .pac-item" + selected + ":first span:nth-child(2)").text()
      $span2 = $(".pac-container:visible .pac-item" + selected + ":first span:nth-child(3)").text()

      #dds the additional information, if available.
      firstResult = $span1
      if ($span2)
        firstResult += " - " + $span2

      @$input.val(firstResult)

      firstResult

    #Restores the input value using the previous value if it exists
    restoreLastValue: ->
      if (@lastInputVal)
        @$input.val(@lastInputVal)

    #Handles the geocode response. If more than one results was found
    #it triggers the "geocode:multiple" events. If there was an error
    #the "geocode:error" event is fired.
    handleGeocode: (results, status)->
      if (status == google.maps.GeocoderStatus.OK)
        result = results[0]
        @$input.val(result.formatted_address)
        @update(result)

        if (results.length > 1)
          @trigger("geocode:multiple", results)

      else
        @trigger("geocode:error", status)

    #Triggers a given `event` with optional `arguments` on the input.
    trigger: (event, argument)->
        @$input.trigger(event, [argument])

    #Set the map to a new center by passing a `geometry`.
    #If the geometry has a viewport, the map zooms out to fit the bounds.
    #Additionally it updates the marker position.
    center: (geometry)->
      if (geometry.viewport)
        @map.fitBounds(geometry.viewport)
        if (@map.getZoom() > @options.maxZoom)
          @map.setZoom(@options.maxZoom)
      else
        @map.setZoom(@options.maxZoom);
        @map.setCenter(geometry.location);

      if (@marker)
        @marker.setPosition(geometry.location)
        @marker.setAnimation(@options.markerOptions.animation)

    #Update the elements based on a single places or geocoding response
    #and trigger the "geocode:result" event on the input.
    update: (result)->
      if (@map)
        @center(result.geometry)

      if (@$details)
        @fillDetails(result)

      @trigger("geocode:result", result)

    #Populate the provided elements with new `result` data.
    #This will lookup all elements that has an attribute with the given
    #component type.
    fillDetails: (result)->
      data = {}
      geometry = result.geometry
      viewport = geometry.viewport
      bounds = geometry.bounds

      #Create a simplified version of the address components.
      $.each(result.address_components, (index, object)->
        name = object.types[0]
      )

      $.each(object.types, (index, name)->
        data[name] = object.long_name
        data[name + "_short"] = object.short_name
      )

      #Add properts of the places details.
      $.each(placesDetails, (index, key)->
        data[key] = result[key]
      )

      #Add infos about the address and geometry.
      $.extend(data,
        formatted_address: result.formatted_address,
        location_type: geometry.location_type || "PLACES",
        viewport: viewport,
        bounds: bounds,
        location: geometry.location,
        lat: geometry.location.lat(),
        lng: geometry.location.lng()
      )

      #Set the values for all details.
      $.each(@details, $.proxy((key, $detail)->
        value = data[key]
        setDetail($detail, value)
      , this))

      @data = data

    #Assign a given `value` to a single `$element`.
    #If the element is an input, the value is set, otherwise it updates
    #the text content.
    setDetail: ($element, value)->
      if (value == undefined)
        value = ""
      else if (typeof value.toUrlValue == "function")
        value = value.toUrlValue()
      
      if ($element.is(":input"))
        $element.val(value)
      else 
        $element.text(value)
      
    #Fire the "geocode:dragged" event and pass the new position.
    markerDragged: (event)->
      @trigger("geocode:dragged", event.latLng)
    

    mapClicked: (event)->
      @trigger("geocode:click", event.latLng)
    
    #Fire the "geocode:mapdragged" event and pass the current position of the map center.
    mapDragged: (event)->
      @trigger("geocode:mapdragged", @map.getCenter())

    #Fire the "geocode:idle" event and pass the current position of the map center.
    mapIdle: (event)->
      @trigger("geocode:idle", @map.getCenter())

    mapZoomed: (event)->
      @trigger("geocode:zoom", @map.getZoom())

    #Restore the old position of the marker to the last knwon location.
    resetMarker: ->
      @marker.setPosition(@data.location)
      @setDetail(@details.lat, @data.location.lat())
      @setDetail(@details.lng, @data.location.lng())

    #Update the plugin after the user has selected an autocomplete entry.
    #If the place has no geometry it passes it to the geocoder.
    placeChanged: ->
      place = @autocomplete.getPlace()
      @selected = true
    
      if (!place.geometry)
        if (@options.autoselect) 
          #Automatically selects the highlighted item or the first item from the
          #suggestions list.
          @autoSelection = @selectFirstResult()
          @find(autoSelection)
      else
        #Use the input text if it already gives geometry.
        @update(place)
            
  )

  #A plugin wrapper around the constructor.
  #Pass `options` with all settings that are different from the default.
  #The attribute is used to prevent multiple instantiations of the plugin.
  $.fn.geocomplete = (options)->
    attribute = 'plugin_geocomplete'

    #If you call `.geocomplete()` with a string as the first parameter
    #it returns the corresponding property or calls the method with the
    #following arguments.
    if (typeof options == "string")

      instance = $(this).data(attribute) || $(this).geocomplete().data(attribute)
      prop = instance[options]
      alert(instance)
      if (typeof prop == "function")
        prop.apply(instance, Array.prototype.slice.call(arguments, 1))
        $(this)
      else 
        if (arguments.length == 2)
          prop = arguments[1]
        prop
    else    
      return this.each(->
        #Prevent against multiple instantiations.
        instance = $.data(this, attribute)
        if (!instance) 
          instance = new GeoComplete( this, options )
          $.data(this, attribute, instance)
      )
) jQuery, window, document

