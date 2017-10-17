<#assign staticPath = ""/>
<!DOCTYPE html>
<head>
<#import "../common-component.ftl" as component>

    <meta charset="utf-8"/>
    <title>项目管理-编辑项目</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <@component.includeCSS staticPath="${staticPath}"/>
    <link href="${staticPath}/media/css/bootstrap-select.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/media/css/xpagination.css" rel="stylesheet" type="text/css" />
    <link href="${staticPath}/media/css/addProject.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
</head>

<body class="page-header-fixed">
<@component.header staticPath="${staticPath}"/>
<div class="page-container">
<@component.navigator staticPath="${staticPath}" mod="project"/>
    <!-- start content -->

    <#if result??><#assign itemDetail = result.data/></#if>

    <div class="page-content">


        <div class="z-detail">
            <ul class="breadcrumb">
                <li>
                    <a href="javascript:void(0)">项目管理</a>
                    <span class="icon-angle-right"></span>
                </li>
                <li>
                    <a href="#">新增项目</a>
                </li>
            </ul>
        </div>
    <#--<#if itemDetail?exists>${itemDetail.itemName!}</#if>-->
        <div class="add-project-content">
            <h3 class="add-project-title">基础信息</h3>
            <div class="add-project-main">
            <form  method="post" action="/item/update" id="itemForm">
                <input type="hidden" id="id" name="id" value="${(itemDetail.id)!}" >
                <div class="add-project-items">
                    <div class="add-project-item clearfix">
                        <label for="" class="item-name">项目名称:</label>
                        <input type="text" name="itemName" id="itemName" class="item-input-default item-project-name" value="${(itemDetail.itemName)!}">
                    </div>
                    <div class="add-project-item clearfix">
                        <label for="" class="item-name">业务类型:</label>
                        <select name="bizType" id="business-type-select" class="item-input-default business-type-select">
                            <option value="1" <#if ((itemDetail.bizType)?? && (itemDetail.bizType!=0)) >selected</#if> >合作</option>
                            <option value="0" <#if ((itemDetail.bizType)?? && (itemDetail.bizType==0)) >selected</#if> >未合作</option>
                        </select>
                    </div>
                    <div class="add-project-item add-project-monthly-service clearfix">
                        <label for="" class="item-name">是否开启包月服务:</label>
                        <div class="project-monthly-service">
                            <label class="monthly-service-text"><input name="service" type="radio" value="" class="monthly-service" <#if ((itemDetail.bizType)?? && (itemDetail.bizType==1)) >checked</#if> /><span>开启</span> </label>
                            <label class="monthly-service-text"><input name="service" type="radio" value="" class="monthly-service" <#if ((itemDetail.bizType)?? && (itemDetail.bizType==2)) >checked</#if> /><span>不开启</span> </label>
                        </div>
                    </div>
                    <div class="add-project-item clearfix">
                        <label for="" class="item-name">停车场名称:</label>
                        <input type="text" name="parkName" id="parkName" class="item-input-default item-park-name" value="${(itemDetail.parkName)!}">
                    </div>
                    <div class="add-project-item clearfix">
                        <label for="" class="item-name">停车场类型:</label>
                        <select name="parkTypeCode" id="item-park-type" class="item-input-default item-park-type" dataCode="${(itemDetail.parkTypeCode)!}" dataName="${(itemDetail.parkTypeName)!}">
                            <option value="">请选择</option>
                            <option value="">配套停车场</option>
                            <option value="">公共停车场</option>
                            <option value="">专用停车场</option>
                        </select>
                    </div>
                    <div class="add-project-item clearfix">
                        <label for="" class="item-name">停车场地址:</label>
                        <select name="provinceCode" id="province" class="select-province" dataCode="${(itemDetail.provinceCode)!}" dataName="${(itemDetail.proviceName)!}">
                            <option value="">请选择省份</option>
                        </select>
                        <select name="cityCode" id="city" class="select-city" dataCode="${(itemDetail.cityCode)!}" dataName="${(itemDetail.cityName)!}>
                            <option value="0">请选择城市</option>
                        </select>
                        <select name="districtCode" id="area" class="select-area" dataCode="${(itemDetail.districtCode)!}" dataName="${(itemDetail.districtName)!}>
                            <option value="0">请选择区域</option>
                        </select>
                        <input name="parkAdress" type="text" id="parkAdress" class="item-street" value="${(itemDetail.parkAdress)!}" placeholder="街道门牌号">
                    </div>
                    <div class="add-project-item clearfix">
                        <label for="" class="item-name">停车场数量:</label>
                        <input name="parkNum" type="text" id="parkNum" class="item-input-default item-park-count" value="${(itemDetail.parkNum)!}">
                    </div>
                    <div class="add-project-item clearfix">
                        <label for="" class="item-name">停车场坐标:</label>
                        <input type="text" name="parkLatAndLot" id="parkLatAndLot" value="${(itemDetail.parkLat)!} ,${(itemDetail.parkLot)!}" placeholder="选择后显示经纬度" readonly class="item-input-default item-park-coordinate">
                        <button type="button" class="btn-coordinate" data-toggle="modal" data-target="#myModal">地图坐标选择</button>
                    </div>
                  <div class="add-project-item clearfix">
                        <label for="" class="item-name">停车场特色:</label>
                        <select id="maxOption" class="selectpicker" name="parkFeature" value="${(itemDetail.parkFeature)!}"  multiple>
                            <option>chicken</option>
                            <option>turkey</option>
                            <option>duck</option>
                            <option>goose</option>
                        </select>
                    </div>
                </div>
                <div class="add-project-btn-box">
                    <button type="button" class="btn-save">保存</button>
                    <button type="button" class="btn-cancel">返回</button>
                </div>
            </form>
            </div>
    </div>
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">
        <div class="modal-header">
            <span>获取经纬度</span>
            <button type="button" class="close city-close" data-dismiss="modal" aria-label="Close"></button>
        </div>
        <input type="text" id="tipinput" placeholder="请在此输入搜索条件"/>
        <div class="modal-search-box clearfix">
            <div class="coordinate-box">
                <span>经度：</span>
                <input type="text" readonly="true" id="longitude">
                <span>纬度：</span>
                <input type="text" readonly="true" id="latitude">
            </div>
        </div>
        <div class="modal-map-body">
            <div id="container"></div>
        </div>
        <div class="modal-footer">
            <button class="map-btn-confirm">确定</button>
            <button class="map-btn-cancel" data-dismiss="modal" aria-label="Close">取消</button>
        </div>
    </div>
    </div>
    <!-- end content -->
</div>

<@component.includeJS/>
<!--日期插件-->
<#--<script src="/media/laydate/laydate.js"></script>
<script src="/media/js/item/item-common.js?2"></script>-->
<script src="${staticPath}/media/js/xpagination.js" type="text/javascript"></script>
<script src="${staticPath}/media/js/bootstrap-select.js" type="text/javascript"></script>
<script src="${staticPath}/media/js/carPort/addProject.js" type="text/javascript"></script>
<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.3&key=b38e7312ca40c291a8ea8dc14dc4e3ba"></script>


</body>
</html>