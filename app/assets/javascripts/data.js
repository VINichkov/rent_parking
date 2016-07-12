
// Получение региона с сессии, если нет то опеределение через ИП
function getArea() {
    var url ="/areas/get_area_session.json";
    var area='';
    $.ajax({
        type: "GET",
        url: url,
        success: function (data) {
            area=data;
        }
    });
    return(area);
}

// Сохранение региона в сессии
function setArea(Area) {
    var url ="/areas/"+Area.toString()+"/set_area_session.json";
    $.ajax({
        type: "GET",
        url: url
    });
}

//Получение списка городов в области. В функцию передается ID области
function getCity(Area) {
    var url ="/city_towns/"+Area.toString()+'/find.json';
    var jsonstr;
    $.ajax({
        type: "GET",
        url: url,
        success: function (data) {
            jsonstr=data;
        }
    });
    return(jsonstr);
}

function getDestriction(arrCity) {

}
//TODO Необходимо добавить алгоритм определения Региона по ИП и сохранение его на сессии
function getAreaIP() {
    return('{"id":1,"name":"Омская область"}');
}