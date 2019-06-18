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
	
	function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/purchase/listManage").submit();
	}
	
	
	 $(function() {
		$( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
			fncGetList(1);
		});
		
		
		
		$( "td:nth-child(4)" ).on("click" , function() {
			self.location ="/product/getProduct?prodNo="+ $(this).children().val()+"&menu=${param.menu}";
			console.log ( $(this).children().val() );
		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
			
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
		$( "button:contains('����ϱ�')" ).on("click" , function() {
			self.location ="/purchase/updateTranCode?tranNo="+$(this).children().val()+"&tranCode="+$(this).parent().children().val() ;
			console.log (    $(this).children().val()    );
			console.log (    $(this).parent().children().val()    );
		});
				
	 });	
	 
	 $(function() {			
			$( "td:nth-child(4) " ).css("font-weight" , "bold");
			//�ֹ���ȣ Ŭ��
			$( "td:nth-child(2)" ).on("click" , function() {
				var tranNo = $(this).text().trim();
				//alert(tranNo);
				
				$.ajax( 
					 		{
								url : "/purchase/json/getPurchase/"+tranNo ,
								method : "GET" ,
								dataType : "json" ,
								headers : {
													"Accept" : "application/json",
													"Content-Type" : "application/json"
													},
								success : function(JSONData , status) {
					
									//alert(status);
									//alert("JSONData : \n"+JSONData);
									if ($.trim(JSONData.paymentOption) == '0' ){JSONData.paymentOption="���ݰ���"}
									if ($.trim(JSONData.paymentOption) == '1' ){JSONData.paymentOption="ī�����"}
		
									var displayValue = "<h6>"
																+"��ǰ��ȣ : "+JSONData.purchaseProd.prodNo+"<br/>"
																+"���Ź�� : "+JSONData.paymentOption+"<br/>"
																+"��� ������ : "+JSONData.mileage+"��<br/>"
																+"�������̸� : "+JSONData.receiverName+"<br/>"
																+"�����ڿ���ó : "+JSONData.receiverPhone+"<br/>"
																+"�������ּ� : "+JSONData.divyAddr+"<br/>"
																+"���ſ�û���� : "+JSONData.divyRequest+"<br/>"
																+"�������� : "+JSONData.divyDate+"<br/>"
																+"�ֹ��� : "+JSONData.orderDate+"<br/>"
																+"</h6>";
																
									//Debug...									
									//alert(displayValue);
									$("h6").remove();
									$( "#"+tranNo+"" ).html(displayValue);
							}
					});
			});

			
			$(  "td:nth-child(3) " ).on("click" , function() {

				var userId = $(this).text().trim();
				var userAjax =     $(      $(  "td:nth-child(3) " ).children()[   $(  "td:nth-child(3) " ).index(this)   ]    );
// 				var userAjax =     $(      $(  "td:nth-child(3) " ).children(   "#"+userId+""    )[   $(  "td:nth-child(3) " ).index(this)   ]    );


				$.ajax( 
						{
							url : "/user/json/getUser/"+userId ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {

								var displayValue = "<h6>"
															+"���̵� : "+JSONData.userId+"<br/>"
															+"��  �� : "+JSONData.userName+"<br/>"
															+"�̸��� : "+JSONData.email+"<br/>"
															+"ROLE : "+JSONData.role+"<br/>"
															+"����� : "+JSONData.regDate+"<br/>"
															+"</h6>";
								$("h6").remove();
								userAjax.html(displayValue);
// 								alert(displayValue);
//  							$( "#"+userId+"" ).html(displayValue);
							}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
				
		});
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
	       <h3>
		       		�ֹ�����      
	       </h3>
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
			    
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		<br/>
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="left">No</th>
			<th align="left" >�ֹ���ȣ</th>
			<th align="left" >��ID</th>
            <th align="left" >��ǰ��</th>
		    <th align="left" >���ż���</th>
            <th align="left">���Ű���</th>
            <th align="left">���ų�¥</th>
            <th align="left">�������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
					  <td align="left">${ i }</td>
					  <td align="left">${ purchase.tranNo }
						  		<span id="${purchase.tranNo}"></span>
					  </td>
					  <td align="left">${ purchase.buyer.userId }
						  		<span id="${purchase.buyer.userId}"></span>
					  </td>
					  <td align="left"  title="Click : ��ǰ���� Ȯ��">${purchase.purchaseProd.prodName} 
								<input type="hidden" value="${purchase.purchaseProd.prodNo}"/>
					  </td>
					  <td align="left">${purchase.tranQuantity}��</td>
					  <td align="left">${purchase.tranPrice}��</td>
					  <td align="left">${purchase.orderDate}</td>
					  <td align="left">
						  		 <input type="hidden" id="tranCode" value="${ purchase.tranCode }"/>	
								 <c:if test="${purchase.tranCode eq '1'}">�ǸſϷ�
								 		 <button type="button" class="btn btn-default btn-xs">����ϱ�
								 		 			<input type="hidden" value="${purchase.tranNo}"/>
								 		 </button>
								 </c:if>
								 <c:if test="${purchase.tranCode eq '2'}">�����</c:if>
								 <c:if test="${purchase.tranCode eq '3'}">������Ȯ��</c:if>
								 <c:if test="${purchase.tranCode eq '4'}">��ҿϷ�</c:if>
					  </td>
<!--				  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodName} "></i>
			  	<input type="hidden" value="${product.prodName} ">
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
