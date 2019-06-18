<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	}
	
	
	$(function() {
		$( "button:contains('수취확인')" ).on("click" , function() {
			var tranNo = $(this).parent(   ).children( $('input') ).val();
			var tranCode = $(this).parent(   ).children( ).eq(1).val();
			self.location ="/purchase/updateTranCode?tranNo="+tranNo+"&tranCode="+tranCode;
			console.log ( "tranNo :: "+ tranNo  );
			console.log ( "tranCode :: "+    $(this).parent(   ).children( ).eq(1).val()     );
		});
		
		$( "button:contains('취소'), button:contains('환불')" ).on("click" , function() {
			var tranNo = $(this).parent(   ).children( ).eq(0).val() ;
			console.log ( tranNo);
			self.location ="/purchase/cancelPurchase?tranNo="+tranNo;
		});
		
// 		$( "button:contains('상세보기')" ).on("click" , function() {
// 			var tranNo = $('td:nth-child(1)').children( ).val() ;
// 			console.log ( tranNo);
// 			self.location ="/purchase/getPurchase?tranNo="+tranNo;
// 		});
		
	});
		
	$(function() {
		//주문번호 클릭
		$( "td:nth-child(2)" ).on("click" , function() {
			var tranNo = $(this).text().trim() ;
			console.log ( tranNo);
			self.location ="/purchase/getPurchase?tranNo="+tranNo;
			
// 			var tranNo = $(this).text().trim();
			//alert(tranNo);
			
// 			$.ajax( 
// 				 		{
// 							url : "/purchase/json/getPurchase/"+tranNo ,
// 							method : "GET" ,
// 							dataType : "json" ,
// 							headers : {
// 												"Accept" : "application/json",
// 												"Content-Type" : "application/json"
// 												},
// 							success : function(JSONData , status) {
				
// 								//alert(status);
// 								//alert("JSONData : \n"+JSONData);
// 								if ($.trim(JSONData.paymentOption) == '0' ){JSONData.paymentOption="현금결제"}
// 								if ($.trim(JSONData.paymentOption) == '1' ){JSONData.paymentOption="카드결제"}
	
// 								var displayValue = "<h6>"
// 															+"상품번호 : "+JSONData.purchaseProd.prodNo+"<br/>"
// 															+"구매방법 : "+JSONData.paymentOption+"<br/>"
// 															+"사용 적립금 : "+JSONData.mileage+"원<br/>"
// 															+"구매자이름 : "+JSONData.receiverName+"<br/>"
// 															+"구매자연락처 : "+JSONData.receiverPhone+"<br/>"
// 															+"구매자주소 : "+JSONData.divyAddr+"<br/>"
// 															+"구매요청사항 : "+JSONData.divyRequest+"<br/>"
// 															+"배송희망일 : "+JSONData.divyDate+"<br/>"
// 															+"주문일 : "+JSONData.orderDate+"<br/><br/>"
// // 															+"<button type=\"button\" class=\"btn btn-default btn-xs\">상세보기</button>"
// 															+"</h6>";
															
// 								//Debug...									
// 								//alert(displayValue);
// 								$("h6").remove();
// 								$( "#"+tranNo+"" ).html(displayValue);
// 						}
// 				});
		});		

	
		
		//상품명 클릭
		$( "td:nth-child(3)" ).on("click" , function() {
			var prodNo = $(	 $( "td:nth-child(3)" )[$( "td:nth-child(3)" ).index(this)] 	).children().val() ;
			self.location ="/product/getProduct?prodNo="+prodNo+"&menu=search";
			console.log (   prodNo          );
		});

		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$( " .ct_list_pop td:nth-child(5)" ).css("font-weight" , "bold");
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
			//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
	});	
	
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>구매목록조회</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    		  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >주문번호</th>
            <th align="left">상품명</th>
            <th align="left">수량</th>
            <th align="left">가격</th>
            <th align="left">주문현황</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr class="purchase">
					
			  <td align="left" >${ i }</td>
			  <td align="left" >${purchase.tranNo}
			  			<span id= "${purchase.tranNo}"></span>
			  </td>
			  <td align="left">${purchase.purchaseProd.prodName }
			  			<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo}"/>
			  </td>
			  <td align="left">${purchase.tranQuantity }개</td>
			  <td align="left"> ${purchase.tranPrice }원</td>
			  <td align="left">
			  			<input type="hidden" value="${purchase.tranNo}"/>
			  			<input type="hidden" value="${purchase.tranCode}"/>
			  			<c:choose>
								<c:when test="${purchase.tranCode eq '1' }">
										구매 완료 <button type="button" class="btn btn-default btn-xs">취소</button>
								</c:when>
								<c:when test="${purchase.tranCode eq '2' }">
										배송 중 <button type="button" class="btn btn-default btn-xs">수취확인</button>
								</c:when>
								<c:when test="${purchase.tranCode eq '3' }"> 
										배송 완료 <button type="button" class="btn btn-default btn-xs">환불</button>
								</c:when>
								<c:otherwise>
										취소 완료
								</c:otherwise>
						</c:choose>
			  </td>
	<!-- 		  <td align="left">
				  	<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo}"></i>
					  	<input type="hidden" value="${purchase.tranNo}"> 
			  </td>-->	
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>