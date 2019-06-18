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
       
       .thumbnail{  
       			 width: 100%; height: 50px; overflow: hidden;  
        }  
       
       img { 
/*       			 max-width: 100%;  */
      			 max-height: 250px; 
      			 min-height: 250px; 
      			 min-width: 245px; 
       }

/* ��ó: https://webdir.tistory.com/487 [WEBDIR] */


    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}
	
	
	 $(function() {
		 $( "button.btn.btn-default" ).on("click" , function() {
			fncGetList(1);
		});
		
		$("span:contains('ǰ��')").on("click" , function() {
			$(  '#soldOut'  ).val(  '0'  );
			fncGetList(1);
		}); 
		
		$("span:contains('����')").on("click" , function() {
			$(  '#searchCondition'  ).val(  '1'  );
			fncGetList(1);
		}); 
		
		$("span:contains('����')").on("click" , function() {
			$(  '#searchCondition'  ).val(  '2'  );
			fncGetList(1);
		}); 
		
		$("span:contains('���')").on("click" , function() {
			$(  '#searchCondition'  ).val(  '3'  );
			fncGetList(1);
		}); 
		
		$("span:contains('�Ż�ǰ')").on("click" , function() {
			$(  '#searchCondition'  ).val(  '4'  );
			fncGetList(1);
		}); 
		
// 		$( "a:contains('�󼼺���')" ).on("click" , function() {	
// 			self.location ="/product/getProduct?prodNo="+ $(this).children().val()+"&menu=${param.menu}";
// 			console.log ( $(  this  ).children().val() );
// 		});
		
// 		$( "img" ).on("click" , function() {	
// 			self.location ="/product/getProduct?prodNo="+  $(  this  ).parent().children().val()+"&menu=${param.menu}";
// 		});
		
		$( ".thumbnail" ).on("click" , function() {	
			self.location ="/product/getProduct?prodNo="+  $(  this  ).children().val()+"&menu=${param.menu}";
		});
		
		$( "a:contains('�ٷα���')" ).on("click" , function() {	
			self.location = "/purchase/addPurchase?prodNo="+$(this).children().val();
			console.log ( $(this).children().val() );
		});
		
// 		$( "a:contains('����')" ).on("click" , function() {	
// 			self.location ="/product/updateProduct?prodNo="+$(this).children().val();
// 			console.log ( $(this).children().val() );
// 		});
		
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
			
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
			
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
		       <c:if test="${ param.menu eq 'manage' }">
		       			��ǰ����
		       	</c:if>
		       <c:if test="${ param.menu ne 'manage' }">
		       			��ǰ�����ȸ
		       	</c:if>	       
	       </h3>
	    </div>
	    
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�
		    		<c:if test="${ !(empty sessionScope.user)   }">
		    		, ���� ${resultPage.currentPage}  ������
		    		</c:if>
		    	</p>
		    </div>

		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
<!-- 			      <div class="form-group"> -->
<!-- 				    <select class="form-control" name="searchCondition" > -->
<%-- 						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>���� ���� ��</option> --%>
<%-- 						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>���� ���� ��</option> --%>
<!-- 					</select> -->
<!-- 				  </div> -->
			    
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/><br/>
				  <input type="hidden" id="searchCondition" name="searchCondition" value=""/><br/>
				  <input type="hidden" id="soldOut" name="soldOut" value="1"/><br/>
				 <c:if test="${ !(empty sessionScope.user)   }">
						  <span> [ǰ����ǰ����] </span>
						  <span> [���� ���� ��] </span>
						  <span> [���� ���� ��] </span>
						  <span> [��� ��] </span>
						  <span> [�Ż�ǰ ��] </span>
				  </c:if>
				</form>
	    	</div>
	    	
		</div>
		

		<!-- table ���� �˻� Start /////////////////////////////////////-->
		

		
		
      <!--  table Start /////////////////////////////////////-->

		<br/>
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
						  <div class="col-sm-4 col-md-3">
						    <div class="thumbnail" style="height: 360px">
<!-- 						    <div class="thumbnail" style="height: 450px; vertical-align: middle;"> -->
								<input type="hidden" name="prodNo" value="${product.prodNo}"/>
						        <img   height="700" src="../images/uploadFiles/${product.fileName}"  height="100" onerror="this.src='http://placehold.it/400x400'" >

						      <div class="caption">
						        <h3 align="center">
						        		<c:if test="${ product.prodQuantity == 0}">
						        		<button  class="btn btn-danger btn-xs">ǰ��</button></c:if>
						    		    ${product.prodName}
						    	</h3>
						        <p align="center">
						        <c:if test="${ param.menu eq 'manage' }">
						        	[��� :  ${product.prodQuantity }��]&nbsp; 
						        </c:if> 
						        ${product.price}��
<%-- 						        <c:if test="${ param.menu eq 'manage' }"> --%>
<!-- 		        						<a href="#" class="btn btn-default btn-xs" role="button">���� -->
<%-- 		        						<input type="hidden" name="prodNo" value="${product.prodNo}"/></a>   --%>
<%-- 		        				</c:if> --%>
						        </p>
<!-- 						        <p align="center"> -->
<!-- 						      					<a href="#" class="btn btn-default" role="button" >�󼼺��� -->
<%-- 						        						<input type="hidden" name="prodNo" value="${product.prodNo}"/> --%>
<!-- 						        				</a> -->
						        				
<%-- 						        				<c:if test="${ param.menu ne 'manage'  && product.prodQuantity != 0}"> --%>
<!-- 						        						<a href="#" class="btn btn-primary" role="button">�ٷα��� -->
<%-- 						        						<input type="hidden" name="prodNo" value="${product.prodNo}"/></a>   --%>
<%-- 						        				</c:if> --%>
<%-- 						        				<c:if test="${ param.menu eq 'manage' }"> --%>
<!-- 						        						<a href="#" class="btn btn-primary btn-xs" role="button">���� -->
<%-- 						        						<input type="hidden" name="prodNo" value="${product.prodNo}"/></a>   --%>
<%-- 						        				</c:if> --%>
<!-- 						        	</p> -->
						      </div>
						    </div>
						  </div>
          </c:forEach>
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->

 	
 	<!-- PageNavigation Start... -->
<%--  	<c:if test="${ !(empty sessionScope.user)   }"> --%>
			<jsp:include page="../common/pageNavigator_new.jsp"/>
<%-- 	</c:if> --%>
	<!-- PageNavigation End... -->
	
</body>
</html>
