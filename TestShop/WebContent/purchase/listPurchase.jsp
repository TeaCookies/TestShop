<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	//�˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit();
	}
	
	
	$(function() {
		$( "button:contains('����Ȯ��')" ).on("click" , function() {
			var tranNo = $(this).parent(   ).children( $('input') ).val();
			var tranCode = $(this).parent(   ).children( ).eq(1).val();
			self.location ="/purchase/updateTranCode?tranNo="+tranNo+"&tranCode="+tranCode;
			console.log ( "tranNo :: "+ tranNo  );
			console.log ( "tranCode :: "+    $(this).parent(   ).children( ).eq(1).val()     );
		});
		
		$( "button:contains('���'), button:contains('ȯ��')" ).on("click" , function() {
			var tranNo = $(this).parent(   ).children( ).eq(0).val() ;
			console.log ( tranNo);
			self.location ="/purchase/cancelPurchase?tranNo="+tranNo;
		});
		
// 		$( "button:contains('�󼼺���')" ).on("click" , function() {
// 			var tranNo = $('td:nth-child(1)').children( ).val() ;
// 			console.log ( tranNo);
// 			self.location ="/purchase/getPurchase?tranNo="+tranNo;
// 		});
		
	});
		
	$(function() {
		//�ֹ���ȣ Ŭ��
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
// 								if ($.trim(JSONData.paymentOption) == '0' ){JSONData.paymentOption="���ݰ���"}
// 								if ($.trim(JSONData.paymentOption) == '1' ){JSONData.paymentOption="ī�����"}
	
// 								var displayValue = "<h6>"
// 															+"��ǰ��ȣ : "+JSONData.purchaseProd.prodNo+"<br/>"
// 															+"���Ź�� : "+JSONData.paymentOption+"<br/>"
// 															+"��� ������ : "+JSONData.mileage+"��<br/>"
// 															+"�������̸� : "+JSONData.receiverName+"<br/>"
// 															+"�����ڿ���ó : "+JSONData.receiverPhone+"<br/>"
// 															+"�������ּ� : "+JSONData.divyAddr+"<br/>"
// 															+"���ſ�û���� : "+JSONData.divyRequest+"<br/>"
// 															+"�������� : "+JSONData.divyDate+"<br/>"
// 															+"�ֹ��� : "+JSONData.orderDate+"<br/><br/>"
// // 															+"<button type=\"button\" class=\"btn btn-default btn-xs\">�󼼺���</button>"
// 															+"</h6>";
															
// 								//Debug...									
// 								//alert(displayValue);
// 								$("h6").remove();
// 								$( "#"+tranNo+"" ).html(displayValue);
// 						}
// 				});
		});		

	
		
		//��ǰ�� Ŭ��
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>���Ÿ����ȸ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    		  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >�ֹ���ȣ</th>
            <th align="left">��ǰ��</th>
            <th align="left">����</th>
            <th align="left">����</th>
            <th align="left">�ֹ���Ȳ</th>
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
			  <td align="left">${purchase.tranQuantity }��</td>
			  <td align="left"> ${purchase.tranPrice }��</td>
			  <td align="left">
			  			<input type="hidden" value="${purchase.tranNo}"/>
			  			<input type="hidden" value="${purchase.tranCode}"/>
			  			<c:choose>
								<c:when test="${purchase.tranCode eq '1' }">
										���� �Ϸ� <button type="button" class="btn btn-default btn-xs">���</button>
								</c:when>
								<c:when test="${purchase.tranCode eq '2' }">
										��� �� <button type="button" class="btn btn-default btn-xs">����Ȯ��</button>
								</c:when>
								<c:when test="${purchase.tranCode eq '3' }"> 
										��� �Ϸ� <button type="button" class="btn btn-default btn-xs">ȯ��</button>
								</c:when>
								<c:otherwise>
										��� �Ϸ�
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
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>