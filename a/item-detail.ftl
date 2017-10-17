<#assign staticPath = "" />
<!DOCTYPE html>
<head>
<#import "../common-component.ftl" as component>
    <meta charset="utf-8"/>
    <title>项目管理-项目详情</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
<@component.includeCSS staticPath="${staticPath}"/>
    <link href="${staticPath}/media/css/projectDetail.css" rel="stylesheet" type="text/css" />
</head>

<body class="page-header-fixed">
<@component.header staticPath="${staticPath}"/>
<div class="page-container">
<@component.navigator staticPath="${staticPath}" mod="project"/>
    <!-- start content -->
    <div class="page-content">
        <div class="z-detail">
            <ul class="breadcrumb">
                <li>
                    <i class="icon-home"></i>
                    <a href="/item/mgt">项目管理</a>
                    <span class="icon-angle-right"></span>
                </li>
                <li><a href="/item/detail">项目详情</a></li>
            </ul>
         </div>


        <div class="project-detail-content">
            <div class="project-detail-main">
                <h3 class="project-detail-title">基础信息</h3>
                <#assign itemDetail = result.data/>
                <div class="project-detail-items">
                    <div class="project-detail-item">
                        <span class="detail-item-name">项目名称：</span>
                        <span>${itemDetail.itemName!}</span>
                    </div>
                    <div class="project-detail-item">
                        <span class="detail-item-name">业务类型：</span>
                        <span>
                           <#-- <#if itemDetail.bizType == 0>未合作</#if>
                            <#if itemDetail.bizType != 0>已合作</#if>-->
                        </span>

                    </div>
                    <div class="project-detail-item">
                        <span class="detail-item-name">是否开启包月服务：</span>
                        <span>
                           <#-- <#if itemDetail.bizType == 1>是</#if>
                            <#if itemDetail.bizType == 2>否</#if>-->
                        </span>
                    </div>
                    <div class="project-detail-item">
                        <span class="detail-item-name">停车场名称：</span>
                        <span>${itemDetail.parkName!}</span>
                    </div>
                    <div class="project-detail-item">
                        <span class="detail-item-name">停车类型：</span>
                        <span>${itemDetail.parkTypeName!}</span>
                    </div>
                    <div class="project-detail-item">
                        <span class="detail-item-name">停车地址：</span>
                        <span>${itemDetail.parkAddress!}</span>
                    </div>
                    <div class="project-detail-item">
                        <span class="detail-item-name">停车位数量：</span>
                        <span>${itemDetail.parkNum!}</span>
                    </div>
                    <div class="project-detail-item">
                        <span class="detail-item-name">停车坐标：</span>
                        <span>${itemDetail.parkLot!} ${itemDetail.parkLat!}</span>
                    </div>
                    <div class="project-detail-item">
                        <span class="detail-item-name">停车场特色：</span>

                       <#list itemDetail.parkFeature as dwg>
                        <span>${dwg.featureName!}</span>
                       </#list>
                    </div>
                </div>

            </div>
        </div>

    </div>
    <!-- end content -->
</div>
<@component.includeJS/>


<script type="text/javascript" >
    $(document).on("click", ".carport_preview", function () {
        var imgUrl = $(this).find('img').attr('src');
        $("#bigImg").attr('src', imgUrl);
        $("#carportBigImgDialog").modal();
    });

</script>
</body>
</html>