package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 구매관리 Controller
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	
	//get
	//@RequestMapping("/addPurchaseView.do")
	@RequestMapping( value="json/addPurchase/{prodNo}", method=RequestMethod.GET)
	public Map addPurchase(@PathVariable int prodNo,
								HttpSession session) throws Exception {

		System.out.println("/purchase/addPurchase : GET");

		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setBuyer((User)session.getAttribute("user"));
		
		Map map = new HashMap();
		map.put("message","addPurchase OK");
		map.put("purchase", purchase);
		
		return map;
	}
	
	
	
	//@RequestMapping("/addPurchase.do")
	@RequestMapping( value="json/addPurchase/{prodNo}", method=RequestMethod.POST)
	public Map addPurchase( @RequestBody Purchase purchase, 
							@PathVariable int prodNo,						
							HttpSession session ) throws Exception {


		System.out.println("/purchase/addPurchase : POST");
		System.out.println("■■■■ 확인 : "+prodNo );
		
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setBuyer((User)session.getAttribute("user"));
		
		//Business Logic
		purchaseService.addPurchase(purchase);
		
		Map map = new HashMap();
		map.put("message","addPurchase OK");
		map.put("purchase", purchase);
		
		return map;
	}
	
	
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping( value="json/getPurchase/{tranNo}", method=RequestMethod.GET)
	public Purchase getPurchase( @PathVariable int tranNo ) throws Exception {
		
		System.out.println("***********************/purchase/json/getPurchase : GET");
		System.out.println("***********************"+tranNo);
		
		//Business Logic
		return purchaseService.getPurchase(tranNo);
	}

	

	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping( value="json/updatePurchase/{tranNo}", method=RequestMethod.GET)
	public Purchase updatePurchase( @PathVariable int tranNo ) throws Exception{

		System.out.println("/purchase/updatePurchase : GET");
		//Business Logic

		return purchaseService.getPurchase(tranNo);
	}
	
	
	
	//@RequestMapping("/updatePurchase.do")
	@RequestMapping( value="json/updatePurchase", method=RequestMethod.POST)
	public Purchase updatePurchase( @RequestBody Purchase purchase) throws Exception{

		System.out.println("/purchase/updatePurchase : POST");
		//Business Logic
		
		purchaseService.updatePurchase(purchase);
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		return purchase;
	}
	
	
	//get
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping( value="json/updateTranCode/{prodNo}/{tranCode}", method=RequestMethod.GET)
	public Purchase updateTranCode( //@RequestBody Purchase purchase , 
									@PathVariable int prodNo ,
									@PathVariable String tranCode ) throws Exception{

		System.out.println("/purchase/updateTranCode : GET");
		
		Product product = productService.getProduct(prodNo);
		Purchase purchase = purchaseService.getPurchase2(prodNo);
	
		if (tranCode.trim().equals("1")) {
			product.setProTranCode("2");
		} else if (tranCode.trim().equals("2")) {
			product.setProTranCode("3");
		} else if (tranCode.trim().equals("3")) {
			product.setProTranCode("0");
		}		
		
		purchase.setTranCode(product.getProTranCode());
		
		//Business Logic
		purchaseService.updateTranCode(purchase);

		return purchase;
	}
	
	
	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping( value="json/listPurchase")
	public Map listPurchase( @RequestBody Search search ,HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
				
		// Business logic 수행
		Map<String , Object> map= purchaseService.getPurchaseList(search, ((User)session.getAttribute("user")).getUserId());
//		Map<String , Object> map= new HashMap<String, Object>();
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("message","purchaseOK");
		
		return map;
	}
	
	
}