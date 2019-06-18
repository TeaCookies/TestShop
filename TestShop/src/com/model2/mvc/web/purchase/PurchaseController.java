package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


//==> 구매관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public PurchaseController(){
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
	@RequestMapping( value="addPurchase", method=RequestMethod.GET)
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, 
												@RequestParam("prodNo") int prodNo,
												Model model,  HttpServletRequest request,
												HttpSession session) throws Exception {

		System.out.println("/purchase/addPurchase : GET"+request.getParameter("tranQuantity"));
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setBuyer((User)session.getAttribute("user"));
		purchase.setTranQuantity(Integer.parseInt(request.getParameter("tranQuantity")));
		
		model.addAttribute("purchase", purchase);
		model.addAttribute("product", productService.getProduct(prodNo));
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	
	
	
	//@RequestMapping("/addPurchase.do")
	@RequestMapping( value="addPurchase", method=RequestMethod.POST)
	public String addPurchase( @ModelAttribute("purchase") Purchase purchase, 
											@RequestParam("prodNo") int prodNo,
											HttpSession session, Model model ) throws Exception {

		System.out.println("/purchase/addPurchase : POST");
		
		Product product=productService.getProduct(prodNo);
		product.setProdQuantity(product.getProdQuantity()-purchase.getTranQuantity());
		System.out.println("■■■■■"+product.getProdQuantity()+", "+purchase.getTranQuantity());
		productService.updateProdQuantity(product);
		purchase.setPurchaseProd(product);
		

		int newMileage = product.getPrice()*purchase.getTranQuantity()*5/100;
		
		User user=(User)session.getAttribute("user");
		if( user.getMileage() == 0 ) {
			user.setMileage(newMileage);
		}else {
			user.setMileage(user.getMileage()-purchase.getMileage()+newMileage);
			
		}
		userService.updateMileage(user);
		purchase.setBuyer(user);
//		purchase.setBuyer((User)session.getAttribute("user"));
		purchase.setTranCode("1");
		
		//Business Logic
		purchaseService.addPurchase(purchase);
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/readPurchase.jsp";
	}
	
	
	
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping( value="getPurchase", method=RequestMethod.GET)
	public String getPurchase( @RequestParam("tranNo") int tranNo , 
																	Model model ) throws Exception {
		
		System.out.println("/purchase/getPurchase : GET");
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setPurchaseProd(productService.getProduct2(tranNo));
		
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	

	
	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping( value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchase( @RequestParam("tranNo") int tranNo , 
																			Model model ) throws Exception{

		System.out.println("/purchase/updatePurchase : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchase.jsp?tranNo="+tranNo;
	}
	
	
	
	
	//@RequestMapping("/updatePurchase.do")
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase( @ModelAttribute("purchase") Purchase purchase , Model model) throws Exception{

		System.out.println("/purchase/updatePurchase : POST");
		//Business Logic
		
		purchaseService.updatePurchase(purchase);
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		purchase.setPurchaseProd(productService.getProduct2(purchase.getTranNo()));
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp?tranNo="+purchase.getTranNo();
	}
	
	
	//get
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping( value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCode( @ModelAttribute("purchase") Purchase purchase , 
										//		@RequestParam("prodNo") int prodNo ,
												@RequestParam("tranNo") int tranNo ,
												@RequestParam("tranCode") String tranCode ,
												Model model) throws Exception{

		System.out.println("/purchase/updateTranCode : GET");
		
//		Product product = productService.getProduct(prodNo);
		Product product = productService.getProduct2(tranNo);
		purchase = purchaseService.getPurchase(tranNo);
		
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

		model.addAttribute("purchase", purchase);
		
		if (tranCode.trim().equals("1")) {
			return "forward:/purchase/listManage";
		}else {	
			return "forward:/purchase/listPurchase";
		}
	}
	
	
	
	
	@RequestMapping( value="cancelPurchase", method=RequestMethod.GET)
	public String cancelPurchase( @ModelAttribute("purchase") Purchase purchase , 
																@RequestParam("tranNo") int tranNo , HttpSession session,
																Model model) throws Exception{
		
		System.out.println("/purchase/cancelPurchase : GET");
	
		//배송코드 바꾸기
		Product product = productService.getProduct2(tranNo);
		purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode("4");
		purchaseService.updateTranCode(purchase);
		
		//새로 적립된 적립금 반환
		User user=(User)session.getAttribute("user");
		user.setMileage(user.getMileage()-product.getPrice()*purchase.getTranQuantity()*5/100);
		
		//사용한 적립금 돌려받기
		user.setMileage(user.getMileage()+purchase.getMileage());
		userService.updateMileage(user);
		purchase.setBuyer(user);
		
		//상품 수량 반환
		product.setProdQuantity(product.getProdQuantity()+purchase.getTranQuantity());
		productService.updateProdQuantity(product);

		model.addAttribute("purchase", purchase);

		return "forward:/purchase/listPurchase";
	}
	
	
	
	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping( value="listPurchase")
	public String listPurchase( @ModelAttribute("search") Search search, Model model , HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
				
		// Business logic 수행
		System.out.println("확인용**************" + ((User)session.getAttribute("user")).getUserId());
		Map<String , Object> map=purchaseService.getPurchaseList(search, ((User)session.getAttribute("user")).getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	
	
	@RequestMapping( value="listManage")
	public String listManage( @ModelAttribute("search") Search search, Model model ) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		// Business logic 수행
		Map<String , Object> map=purchaseService.getPurchaseList(search, null);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		

		return "forward:/purchase/listManage.jsp";

	}
	
	

	
	
	
	
}