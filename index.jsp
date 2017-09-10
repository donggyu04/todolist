<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
<link href="/css/footer.css" rel="stylesheet" type="text/css">
<link href="/css/main.css" rel="stylesheet" type="text/css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
<script src="/js/helper.js"></script>
<title>NTS</title>
</head>
<body>
	<header>
		<div align="center">
			<jsp:include page="/WEB-INF/jsp/include/header.jsp" />
		</div>
		<div style="height: 50px;"></div>
	</header>
	<div class="nav-div" align="center">
		<div class="tag-wrap" align="left" id="filter-btn-div">
			<div class="tag-container">
				<b style="font-size: 30px;">#태그</b>
				<select class="tag-select" id="tag-filter">
					<option value="all">전체</option>
					<option value="my">내 관심 태그</option>
				</select>
				<select class="tag-select" id="tag-select">
					<option value="all">전체</option>
					<c:forEach items="${ tagList }" var="tag">
						<option value="${ tag.tagNm }">#${ tag.tagNm }</option>
					</c:forEach>
				</select>
				<select class="tag-select" id="myTag-select">
					<option value="all">전체</option>
					<c:forEach items="${ myTagList }" var="myTag">
						<option value="${ myTag }">#${ myTag }</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div align="left" style="width: 980px;">
			<div class="container">
			    <div class="row">    
			        <div style="width: 980px;">
					    <div class="input-group">
					    	<select class="area-filter" id="area-filter">
								<option value="all">전국</option>
								<option value="서울특별시">서울특별시</option>
								<option value="부산광역시">부산광역시</option>
								<option value="인천광역시">인천광역시</option>
								<option value="대구광역시">대구광역시</option>
								<option value="대전광역시">대전광역시</option>
								<option value="광주광역시">광주광역시</option>
								<option value="울산광역시">울산광역시</option>
								<option value="경기도">경기도</option>
								<option value="강원도">강원도</option>
								<option value="충청남도">충청남도</option>
								<option value="충청북도">충청북도</option>
								<option value="전라남도">전라남도</option>
								<option value="전라북도">전라북도</option>
								<option value="경상남도">경상남도</option>
								<option value="경상북도">경상북도</option>
								<option value="제주특별자치도">제주특별자치도</option>
							</select>
							
					    	<select class="area-select" id="area-select"></select>
							
					    	<select class="sort-select" id="sort-select">
								<option value="date">최신 순</option>
								<option value="like">좋아요 순</option>
								<option value="rate">평점 순</option>
								<option value="bkmk">즐겨찾기 순</option>
							</select>
					    	    
			                <input class="input-search" type="text" name="searchText" placeholder="업체를 입력하세요.(미입력 시 전체 검색)" id="input-search" size="50">
			                    <button style="background: #1EDC00; height: 50px; width: 70px;" class="btn btn-default" type="button" onclick="search();"><span
			                   style="color: white; font-weight: bold;">검색</span></button>
			                
			            </div>
			        </div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="wrap" align="center">
		<div class="content" align="left" style="margin-left: 50px;">
			<c:if test="${ empty storeList }">
				검색결과가 존재하지 않습니다.
			</c:if>
			<c:forEach items="${ storeList }" var="store">
				<c:if test="${ store.stat eq 'N' }">
					<div class="card">
						<c:if test="${ store.authn eq 'Y' }">
			 				<img class="option" src="/img/verified.png">
						</c:if>
						<c:if test="${ store.authn eq 'N' }">
			 				<img class="option" style="visibility: hidden;">
						</c:if>
							<a href="/store/detail/${ store.id }">
								<img class="store-title-img" src="/image/${ store.titlImg }" onerror="this.src='/img/sample3.png'">
							</a>
	 					<div class="store-data-div">
							<div class="store-title-div"><strong>${ store.hedLne }</strong></div>
							<c:choose>
								<c:when test="${ store.rateAvr eq '0' }">
									<span class="star">☆☆☆☆☆</span>
								</c:when>
								<c:when test="${ store.rateAvr eq '1' }">
									<span class="star">★☆☆☆☆</span>
								</c:when>
								<c:when test="${ store.rateAvr eq '2' }">
									<span class="star">★★☆☆☆</span>
								</c:when>
								<c:when test="${ store.rateAvr eq '3' }">
									<span class="star">★★★☆☆</span>
								</c:when>
								<c:when test="${ store.rateAvr eq '4' }">
									<span class="star">★★★★☆</span>
								</c:when>
								<c:when test="${ store.rateAvr eq '5' }">
									<span class="star">★★★★★</span>
								</c:when>
							</c:choose>
							<span class="span-review-count">(${ store.numOfrevw })</span>
							<span style="float: right; margin-top: 5px;">
								<span><img width="17px" height="18px" src="/img/thumb_off.png"/>
								<span style="color: #555; font-weight: bold; font-size: 10px;">(<span id="like-span">${ store.likeCount }</span>)</span></span>
								<span><img width="17px" height="18px" src="/img/star_on.png"/>
								<span style="color: #555; font-weight: bold; font-size: 10px;">(<span id="bkmk-span">${ store.bkmkCount }</span>)</span></span>
							</span>
							<span style="clear: both;"></span>
						</div>
						<div class="user-info-div">
							<div class="store-user-id-div">
								<span>${ store.stoNm }</span>
							</div>
							<div style="padding-top: 4px; float:right;">
								<span style="font-size: 12px;">${ store.regDt }</span>
							</div>
							<div style="clear: both;"></div>
						</div> 
					</div>
				</c:if>
				<c:if test="${ store.stat eq 'B' }">
					<div class="card">
						<a href="/store/detail/${ store.id }" onclick="return alertBlind();">
							<img class="blind-img" src="/img/blind.PNG" onerror="this.src='/img/sample3.png'">
						</a>
						<span style="clear: both;"></span>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<div style="clear: both;"></div>
		<div class="page-nav" align="center" style="margin-top: 20px;">
	          <ul class="pagination">
	            <li class="disabled"><a href="#"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
	            <c:forEach var="i" begin="1" end="${ pageCount }" step="1">
	            	<li <c:if test="${ param.page eq i or (empty param.page and i eq 1)}">class="active"</c:if>>
	            		<a href="/?page=${ i }&pageSize=16">${ i }</a>
	            	</li>
	            </c:forEach>
	            <li><a href="#"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
	          </ul>
		</div>
	</div>
	<form action="/store/list" id="search-form" name="search-form">
		<input type="hidden" name="page" value="1"/>
		<input type="hidden" name="pageSize" value="16"/>
		<input type="hidden" name="sort"/>
		<input type="hidden" name="searchText"/>
		<input type="hidden" name="tag"/>
		<input type="hidden" name="area"/>
		<input type="hidden" name="areaFilter"/>
		<input type="hidden" name="tagFilter"/>
	</form>
	<footer>
		<jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
	</footer>
	<script>
		
		// 검색조건 세팅
		$.ajax({
			type: 'get',
			url: '/store/addr',
			dataType: 'json',
			data: {
				'filter': '${pageRequest.areaFilter}'
			},
			success: function(data){
				$('#area-select').html('');
				
				for(var i=0; i < data.length; i++){
					$('#area-select').append('<option value="'+ data[i] +'">'+ data[i] +'</option>');
				}
				if( data.length == 0){
					$('#area-select').append('<option value="none">검색결과 없음(상권은 검색에서 배제됩니다.)</option>');
				}
				else{		
					$('#area-select').append('<option value="none">전지역 검색</option>');
				}
				initSearchDatas();
			},
			error: function(){	
				alert('서비스 점검 중입니다. 잠시 후 다시 시도하세요.');
			}
		});
	
		$('.search-type').on('click', function(){
			$('#search_concept').html($(this).html());
			$('#search_concept').data('search-type', $(this).data('search-type'));
		});
		
		$('.sort-type').on('click', function(){
			$('#sort_concept').html($(this).html());
			$('#sort_concept').data('sort-type', $(this).data('sort-type'));
		});
		
		function search(){
			document.forms['search-form'].elements['sort'].value = $('#sort-select').val();
			document.forms['search-form'].elements['searchText'].value = $('#input-search').val();
			
			if($('#tag-filter').val() == 'all'){	
				document.forms['search-form'].elements['tag'].value = $('#tag-select').val();
			}else{
				document.forms['search-form'].elements['tag'].value = $('#myTag-select').val();
			}
			
			document.forms['search-form'].elements['area'].value = $('#area-select').val();
			document.forms['search-form'].elements['areaFilter'].value = $('#area-filter').val();
			document.forms['search-form'].elements['tagFilter'].value = $('#tag-filter').val();
			$('#search-form').submit();
		}
		
		$('#input-search').keydown(function(event){
			if(event.keyCode == 13){ // enter key
				search();
			}
		});
		
		function initSearchDatas(){
			$('#sort-select').val('${pageRequest.sort}');
			$('#input-search').val('${pageRequest.searchText}');
			$('#area-select').val('${pageRequest.area}');
			$('#area-filter').val('${pageRequest.areaFilter}');
			$('#tag-filter').val('${pageRequest.tagFilter}');
			if($('#tag-filter').val() == 'all'){
				$('#tag-select').css('display', 'inline');
				$('#myTag-select').css('display', 'none');
				$('#tag-select').val('${pageRequest.tag}');
			}else{
				$('#tag-select').css('display', 'none');
				$('#myTag-select').css('display', 'inline');
				$('#myTag-select').val('${pageRequest.tag}');
			}
		}
		
		function alertBlind(){
			alert('해당 업체는 blind되었습니다.');
			return false;
		}
		
		$('#tag-filter').change(function(){
			tagSwitch(this);
		});
		
		$('#area-filter').change(function(){
			getAddr($('#area-filter').val());
		});
		
		function getAddr(filter){
			$.ajax({
				type: 'get',
				url: '/store/addr',
				dataType: 'json',
				data: {
					'filter': filter
				},
				success: function(data){
					$('#area-select').html('');
					
					for(var i=0; i < data.length; i++){
						$('#area-select').append('<option value="'+ data[i] +'">'+ data[i] +'</option>');
					}
					if( data.length == 0){
						$('#area-select').append('<option value="none">검색결과 없음(상권은 검색에서 배제됩니다.)</option>');
					}
					else{		
						$('#area-select').append('<option value="none">전지역 검색</option>');
					}
				},
				error: function(){	
					alert('서비스 점검 중입니다. 잠시 후 다시 시도하세요.');
				}
			});
		}
		
		function tagSwitch(thiz){
			if($(thiz).val() == 'all'){
				$('#tag-select').css('display', 'inline');
				$('#myTag-select').css('display', 'none');
			}else{
				$('#tag-select').css('display', 'none');
				$('#myTag-select').css('display', 'inline');
			}
		}
	</script>
</body>
</html>