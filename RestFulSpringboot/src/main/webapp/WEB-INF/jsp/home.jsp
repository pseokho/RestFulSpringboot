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

.wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
.wrap * {padding: 0;margin: 0;}
.wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
.wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
.info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
.info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
.info .close:hover {cursor: pointer;}
.info .body {position: relative;overflow: hidden;}
.info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
.desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
.desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
.info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
.info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.info .link {color: #5085BB;}
</style>

<title>Login Demo - Kakao JavaScript SDK</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<script type="text/javascript">
var listSize = 15;
var pageNum  = 1;
var maxPage = 3;
var flag = "search";
$(document).ready(function() {
	
    //검색 버튼 눌러렀을때
    $(".search").on("click", function() {
        serachList();
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

function noSpaceForm(obj) { // 공백사용못하게
	    var str_space = /\s/;  // 공백체크
	    if(str_space.exec(obj.value)) { //공백 체크
	        alert("공백 입력시 키워드 검색이 불가능합니다.\n\n공백은 자동적으로 제거 됩니다.");
	        obj.focus();
	        obj.value = obj.value.replace(' ',''); // 공백제거
	        return false;
	    }
}
	
//페이징 버튼을위한 함수
function serachPageingList(pageNum,maxPage)	{

    $.ajax({	
            url: "/pageSerach",	 // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
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
                el= document.createElement('li'), 
                itemStr = '<span class="markerbg marker_' + (key+1) + '"></span>'; 
                itemStr +="<div class='info'>" +  " <h5 class='h5' value ='"+value.place_name+"'>" + value.place_name + "</h5>";
                itemStr +="<span class='road_adress_name' value='"+value.road_address_name+"'>" + value.road_address_name + "</span>";
                itemStr +="<span class='jibun gray' value='"+value.address_name +"'>" +  value.address_name  + "</span>";
                itemStr +="<span class='tel'>" + value.phone  + "</span>";
                itemStr +='<a href =' + directUrl +' target="_blank" >지도 바로가기</a> ' + '</div>' + '</div>';
                itemStr +="<input type='hidden' class='x' id = 'x' value ='"+value.x+"' >";
                itemStr +="<input type='hidden' class='y' id = 'y' value ='"+value.y+"' >";
                el.innerHTML = itemStr;
                el.className = 'item';
                item+=el;
                $('#placesList').append(el);
            })

			//페이징 처리
            $("#pagination").empty();
            for(var i=1; i<=maxPage; i++) {
                var btn = "<button class='pageBtn' id ='"+i+"'style='width: 20px;' value='"+i+"'>"+i+"</button>";
            	$("#pagination").append(btn);
            }
			 $('#pagination').find('.pageBtn').click(function(){
					var temp = $(this).attr('value');
			    	pageNum =temp;
			    	serachPageingList(pageNum,maxPage);
			 })        
            
	         $('#placesList').find('li').click(function(){
	            var xPosition = $(this).find('.x').val();
	            var yPosition = $(this).find('.y').val();
				var placeName = $(this).find('.h5').attr('value');
				var adress = $(this).find('.road_adress_name').attr('value');
				var jibun = $(this).find('.jibun').attr('value');
	                
				drawMapList(xPosition, yPosition,placeName,adress,jibun);
	        });
         })
         .fail(function() {
             alert("요청 실패");
         })	
}

//검색 버튼 눌렀을대 동작한다..
function serachList()	{
	var listSize = 15;
	var pageNum  = 1;
	var maxPage = 3;
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
                el= document.createElement('li'), 
                itemStr = '<span class="markerbg marker_' + (key+1) + '"></span>'; 
                itemStr +="<div class='info'>" +  " <h5 class='h5' value ='"+value.place_name+"'>" + value.place_name + "</h5>";
                itemStr +="<span class='road_adress_name' value='"+value.road_address_name+"'>" + value.road_address_name + "</span>";
                itemStr +="<span class='jibun gray' value='"+value.address_name +"'>" +  value.address_name  + "</span>";
                itemStr +="<span class='tel'>" + value.phone  + "</span>";
                itemStr +='<a href =' + directUrl +' target="_blank" >지도 바로가기</a> ' + '</div>' + '</div>';
                itemStr +="<input type='hidden' class='x' id = 'x' value ='"+value.x+"' >";
                itemStr +="<input type='hidden' class='y' id = 'y' value ='"+value.y+"' >";
                el.innerHTML = itemStr;
                el.className = 'item';
                item+=el;

                
                $('#placesList').append(el);
            })

			//페이징 처리
            $("#pagination").empty();
            for(var i=1; i<=maxPage; i++) {
                var btn = "<button class='pageBtn' style='width: 20px;' value='"+i+"'>"+i+"</button>";
            	$("#pagination").append(btn);
            }
            
			 $('#pagination').find('.pageBtn').click(function(){
					var temp = $(this).attr('value');
			    	pageNum =temp;
			    	serachPageingList(pageNum,maxPage);
			 })
            
            $('#placesList').find('li').click(function(){
                var xPosition = $(this).find('.x').val();
                var yPosition = $(this).find('.y').val();
				var placeName = $(this).find('.h5').attr('value');
				var adress = $(this).find('.road_adress_name').attr('value');
				var jibun = $(this).find('.jibun').attr('value');
                
				drawMapList(xPosition, yPosition,placeName,adress,jibun);
            });
         })
         .fail(function() {
             alert("요청 실패");
         })	
}

// 유저에 이력을 검색한다.
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
//인기검색어를 검색한다.
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
                <input type="text" value="" id="keyword" size="15" onkeyup="noSpaceForm(this);" onchange="noSpaceForm(this);">
                <button class="search" type="submit" >검색하기</button>
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
    function drawMapList (xPosition, yPosition,placeName,adress,jibun){
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



     	// 커스텀 오버레이에 표시할 컨텐츠 입니다
     	// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
     	// 별도의 이벤트 메소드를 제공하지 않습니다 
     	var content = '<div class="wrap">' 
         	+ '<div class="info">' 
         	+ '<div class="title">' 
         	+ placeName 
            + '<div class="close" onclick="closeOverlay()" title="닫기"></div>' 
            + '</div>' 
            + '<div class="body">' 
            + '<div class="img">' 
            + '</div>' 
            + '<div class="desc">' 
            + '<div class="ellipsis">'+adress+'</div>' 
            + '<div class="jibun ellipsis">'+jibun+'</div>' 
            + '</div>' 
            + '</div>' 
            + '</div>' 
            + '</div>';

     	// 마커 위에 커스텀오버레이를 표시합니다
     	// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
     	var overlay = new kakao.maps.CustomOverlay({
         	content: content,
         	map: map,
        	position: marker.getPosition()       
     	});

     	// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
     	kakao.maps.event.addListener(marker, 'click', function() {
        	overlay.setMap(map);
     	});

     	// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
     	function closeOverlay() {
        	overlay.setMap(null);     
		}
    }

</script>

</body>

</html>