<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>

<title>Login Demo - Kakao JavaScript SDK</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<script type="text/javascript">
var listSize = 15;
var pageNum  = 1;
var maxPage = 3;
$(document).ready(function() {
	
    //검색 버튼 눌러렀을때
    $(".search").on("click", function() {
        pageNum=1;
    	maxPage=3;
        serachList(pageNum,maxPage);
    });	
    //내검색목록 눌러렀을때
    $(".userSearchHist").on("click", function() {
        userSearchHistList();
    }); 
    //인기 검색어 목록 눌러렀을때
    $(".popularSearches").on("click", function() {
        popularSearchesList();
    }); 
});

function serachList(pageNum,maxPage)	{

    $.ajax({	
            url: "/serach",	 // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
            data: {keyword : $('#keyword').val() , listSize : listSize , pageNum: pageNum}, // HTTP 요청과 함께 서버로 보낼 데이터
            method: "GET",  // HTTP 요청 방식(GET, POST)
            contentType: "application/x-www-form-urlencoded; charset=UTF-8"
          })
        .done(function(result) {	
            var item = "";
            var pasobj=JSON.parse(result); 
            $("#placesList").empty();
            var el ;
    		maxPage = pasobj.meta.pageable_count/listSize;
			$.each(pasobj.documents, function(key,value) {
                if(key ==0){
                    drawMap(value.x, value.y); //검색 로딩후 첫번째 값에 지도좌표로 지도 다시그리기
                 }
                var directUrl =    "https://map.kakao.com/link/map/" + value.y+"," + value.x;
                el= document.createElement('li'), itemStr = '<span class="markerbg marker_' + (key+1) + '"></span>' + '<div class="info">' +  ' <h5>' + value.place_name + '</h5>';
                itemStr += ' <span>' + value.road_address_name + '</span>' + ' <span class="jibun gray">' +  value.address_name  + '</span>';
                itemStr += ' <span class="tel">' + value.phone  + '</span>'
                itemStr += ' <a href =' + directUrl +' target="_blank" >지도 바로가기</a> ' + '</div>' + '</div>';
                itemStr += "<input type='hidden' class='x' id = 'x' value ='"+value.x+"' >";
                itemStr += "<input type='hidden' class='y' id = 'y' value ='"+value.y+"' >";
                el.innerHTML = itemStr;
                el.className = 'item';
                item+=el;

                $('#placesList').append(el);
            })

			//페이징 처리
            $("#pagination").empty();
            var nextBtn = "<button class='next'>다음</button>";
            var prevBtn = "<button class='prev'>이전</button>";

            if(pageNum<maxPage){
                $("#pagination").append(nextBtn);
            }
            if(1<pageNum){
           		$("#pagination").append(prevBtn);
            }
		
            $('#pagination').find('.next').click(function(){
               	pageNum =pageNum+1;
               	serachList(pageNum,maxPage);
            })
            
            $('#pagination').find('.prev').click(function(){
               	pageNum =pageNum-1;
               	serachList(pageNum,maxPage);
            })
            
            $('#placesList').find('li').click(function(){
                var xPosition = $(this).find('.x').val();
                var yPosition = $(this).find('.y').val();
                drawMap(xPosition, yPosition);
            });
         })
         .fail(function() {
             alert("요청 실패");
         })	
}

function userSearchHistList()   {
    $.ajax({   
        url: "/userSearchHist",   // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
        method: "GET",  // HTTP 요청 방식(GET, POST)
        contentType: "application/x-www-form-urlencoded; charset=UTF-8"
      })
    .done(function(result) {
        $("#searchHistList").empty();

        var item = "";
        var pasobj=JSON.parse(result); 
        item += "<label> 내 검색 히스토리 </label>"
        item += "<table border ='1px'>";
        item += "<tr>";
        item += "<td> 검색어 </td>";
        item += "<td> 검색일시 </td>";
        item += "</tr>";
        $.each(pasobj.data, function(key,value) {
            item += "<tr>";
            item += "<td> ";
            item += value.KEYWORD;
            item += "</td>";
            item += "<td> ";
            item += value.SEARCH_TIME;
            item += "</td>";
            item += "</tr>";
        })
        item+="</table>";
        $('#searchHistList').append(item); 
        
     })
     .fail(function() {
         alert("요청 실패");
     }) 
}
function popularSearchesList()   {
     
    $.ajax({   
        url: "/popularSearchesHist",   // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
        method: "GET",  // HTTP 요청 방식(GET, POST)
        contentType: "application/x-www-form-urlencoded; charset=UTF-8"
      })
    .done(function(result) {
        $("#searchHistList").empty();

        var item = "";
        var pasobj=JSON.parse(result); 


        item += "<label> 인기 키워드 목록 </label>"
        item += "<table border ='1px'>";
        item += "<tr>";
        item += "<td> 검색어 </td>";
        item += "<td> 횟수 </td>";
        item += "</tr>";
        $.each(pasobj.data, function(key,value) {
            item += "<tr>";
            item += "<td> ";
            item += value.KEYWORD;
            item += "</td>";
            //지번
            item += "<td>";
            item += value.SEARCHCOUNT;
            item += "</td>";

            item += "</tr>";

        })
        item+="</table>";
        $('#searchHistList').append(item); 
        

     })
     .fail(function() {
         alert("요청 실패");
     }) 
}
</script>
<body>
<div style='display:inline;min-width:130px;'>
    <div class="map_wrap" style='display:inline;float:left;width:1000px'>
        <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

        <div id="menu_wrap" class="bg_white">
            <div class="option">
                <lable>${username}</lable>
                <input type="text" value="" id="keyword" size="15">
                <button class="search" type="submit">검색하기</button>
            </div>
        <hr>
        <ul id="placesList">
         </ul>
        <div id="pagination"></div>
        </div>
    </div>
    <div id ="serarchHist" style="display:inline;float:left;width:300px">
         <div id="hist_wrap">
            <div class="option">
                <button class="userSearchHist" type="submit" style="display:inline;width: 75px;">내 검색 목록</button>
                <button class="popularSearches" type="submit" style="display:inline;width: 100px;">인기 키워드 목록</button>
            </div>
        <hr>
        <ul id="searchHistList" style="padding: 0px;">
        </ul>
        </div>
    </div>


<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a3e264ee681f0ca6bb7c3327986b38cd&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    //기본 위치에대한 설정
    mapOption = {
        center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level : 3 // 지도의 확대 레벨
    };
 
    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption);

    function drawMap (xPosition , yPosition){
        mapOption = {
            center : new kakao.maps.LatLng(yPosition, xPosition), // 지도의 중심좌표
            level : 3// 지도의 확대 레벨
            };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var markerPosition  = new kakao.maps.LatLng(yPosition, xPosition);// 마커가 표시될 위치입니다
        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            position: markerPosition
        });
        // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);
    }

</script>

</body>

</html>