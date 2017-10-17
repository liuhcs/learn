
/**
 * 获取省级用户信息
 */
var province = document.getElementById("province");
var city = document.getElementById("city");
var area = document.getElementById("area");
var  feature=document.getElementById("maxOption");

var itemParkTypeSelect = document.getElementById("item-park-type");
var url;
var subData = new Object();
var flag =true;
var basePath=getRootPath();
$(function() {



    if(flag){//新增
        renderProvince()//初始化省数据
        url="item/save";
    }else{//编辑
        province[0]= new Option($("#province").attr("dataCode"), $("#province").attr("dataName"));
        city[0]= new Option($("#city").attr("dataCode"), $("#city").attr("dataName"));
        area[0]= new Option($("#area").attr("dataCode"), $("#area").attr("dataName"));

        itemParkTypeSelect[0] = new Option($("#item-park-type").attr("dataCode"), $("#item-park-type").attr("dataName"));
        url="item/update";
    }
    /**-------------------------------------业务类型-------------------------------------*/
    $("#business-type-select").on("change", function() {
        var businessIndex = document.getElementById('business-type-select').selectedIndex;
        businessIndex === 1 ?  $('.add-project-monthly-service').show() : $('.add-project-monthly-service').hide();
    });
    /**--------------------------------------省市区组件绑定---------------------------------*/
    $(".add-project-item").on("change", "#province", function() {
        renderCity();
    });
    $(".add-project-item").on("change", "#city", function() {
        renderArea();
    });
    /**-------------------------------------地图----------------------------------------------*/
    //地图坐标选择
    var map = new AMap.Map('container',{
        resizeEnable: true,
        zoom: 10,
        center: [120.215374,30.244759]
    });
    var clickEventListener = map.on('click', function(e) {
        document.getElementById("longitude").value = e.lnglat.getLng();
        document.getElementById("latitude").value = e.lnglat.getLat();
    });
    AMap.plugin(['AMap.Autocomplete','AMap.PlaceSearch'],function(){
        var autoOptions = {
            city: "北京", //城市，默认全国
            input: "tipinput"//使用联想输入的input的id
        };
        autocomplete= new AMap.Autocomplete(autoOptions);
        var placeSearch = new AMap.PlaceSearch({
            city:'北京',
            map:map
        });
        AMap.event.addListener(autocomplete, "select", function(e){
            //TODO 针对选中的poi实现自己的功能
            placeSearch.setCity(e.poi.adcode);
            placeSearch.search(e.poi.name)
        });
    });
    //地图坐标弹框确定按钮事件
    $('.modal-footer').on("click", ".map-btn-confirm", function() {
        var lngVal = $("#longitude").val();
        var latVal = $("#latitude").val();
        $(".item-park-coordinate").val(lngVal + ' , ' + latVal);
        $('#myModal').modal('hide');
    });
    /**------------------------------------提交按钮绑定事件------------------------------------------------*/
    $(".btn-save").click(function() {
        addProjectValidate();
        if(flag)subData.id=$("#id").val();
        subData.itemName=$("#itemName").val();
        subData.bizType=$("#business-type-select").val();
        subData.parkName=$("#parkName").val();
        subData.parkTypeCode=$("#item-park-type").val();
        subData.parkTypeName=$("#item-park-type").text();
        subData.provinceCode=$("#province").val();
        subData.provinceName=$("#province").text();
        subData.cityCode=$("#city").val();
        subData.cityName=$("#city").text();
        subData.districtCode=$("#area").val();
        subData.districtName=$("#area").text();
        subData.parkAdress=$("#parkAdress").val();
        subData.parkNum=$("#parkNum").val();
        var latAndLot=$("#parkLatAndLot").val().split(" ,");
        subData.parkLot=latAndLot[1];
        subData.parkLat=latAndLot[0];
        var parkFeature=$("#maxOption").val();
        console.log(subData);

        Request.commonAjax(url, subData, function(data){
            //判定是否提交成功

            window.location.href = "/item/mgt"

        });
    });
});
function renderFeature() {
    $.ajax({
        type: "post",
        url: "api/item/parkFeatureList",
        cache: false,
        error: function () {

        },
        success: function (result) {
            var data=result.data;
            for (var i = 0; i < data.length; i++) {
                feature[i+1] = new Option(data[i].key, data[i].value);
            }
        }
    });
}

function renderProvince() {
    $.ajax({
        type: "post",
        url: basePath+"/api/item/searchRemoteAllProvinces",
        cache: false,
        error: function () {

        },
        success: function (result) {
            var data=result.data;
            for (var i = 0; i < data.length; i++) {
                province[i+1] = new Option(data[i].name,data[i].code );
            }
        }
    });
}

function renderCity() {
    var provinceCode =  $("#province").val();
    $.ajax({
        type: "post",
        url: "api/item/searchRemoteCityByProvinceCode?code="+provinceCode,
        cache: false,
        error: function () {

        },
        success: function (result) {
            var data=result.data;
            for (var i = 0; i < data.length; i++) {
                area[i+1] =  new Option(data[i].name,data[i].code );

            }
        }
    });
}
function renderArea() {
    var cityCode =  $("#city").attr("data");
    $.ajax({
        type: "post",
        url: "api/item/searchRemoteAreaByCityCode?code="+cityCode,
        cache: false,
        error: function () {

        },
        success: function (result) {
            var data=result.data;
            for (var i = 0; i < data.length; i++) {
                city[i+1] = new Option(data[i].name,data[i].code );

            }
        }
    });
}

//新增项目表单验证
function addProjectValidate() {


    //项目名称
    var proNameVal = $(".item-project-name").val();
    //项目类型
    var businessType = document.getElementById('business-type-select');
    //包月服务
    var serviceOpen = $(".monthly-service-open").prop('checked');
    var serviceClose = $(".monthly-service-close").prop('checked');
    //停车场名称
    var parkName = $(".item-park-name").val();
    //停车场类型
    var parkType = document.getElementById('item-park-type');
    //停车场地址
    var parkProvince = document.getElementById('province').selectedIndex;
    var parkCity = document.getElementById("city").selectedIndex;
    var parkArea = document.getElementById("area").selectedIndex;
    var parkStreet = $(".item-street").val();
    //停车场数量
    var parkCount = $(".item-park-count").val();
    var regCount = /^[1-9]*[1-9][0-9]*$/;
    //停车场坐标
    var parkCoordinate = $(".item-park-coordinate").val();
    //停车场特色
    var parkCharac = $(".dropdown-menu").find("li").hasClass("selected")

    if(proNameVal === '') {
        popup.error('请输入项目名称 ');
        return false;
    }else if(businessType.selectedIndex === 0) {
        popup.error('请选择项目类型 ');
        return false;
    }else if(!serviceOpen && !serviceClose) {
        popup.error('请选择包月服务');
        return false;
    }else if(parkName === '') {
        popup.error('请输入停车场名称 ');
        return false;
    }else if(parkType.selectedIndex === 0) {
        popup.error('请选择停车场类型');
        return false;
    }else if(parkProvince === 0 || parkCity === 0 || parkArea === 0 || parkStreet === '') {
        popup.error('请选择停车场地址');
        return false;
    }else if(!regCount.test(parkCount) || parkCount === '') {
        popup.error('请输入正确的停车场数量');
        return false;
    }else if(parkCoordinate === '') {
        popup.error('请选择停车场坐标');
        return false;
    }else if(!parkCharac) {
        popup.error('请选择停车场特色');
        return false;
    }
}
function getRootPath(){
    var currentPagepath=location.href;
    var pathName = window.document.location.pathname;
    var pos = currentPagepath.indexOf(pathName);
    var localhostPath = currentPagepath.substring(0,pos);
    //var projectName = pathName.substring(0,pathName.substr(1).indexOf("/")+1);
    return localhostPath;
}
$('#usertype').selectpicker({
    'selectedText': 'cat'
});