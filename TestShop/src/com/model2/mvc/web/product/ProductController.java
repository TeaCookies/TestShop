package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.UploadFile;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 판매관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	//setter Method 구현 않음
	
	@Resource(name = "uploadPath")
	private String uploadPath;

	
	public ProductController(){
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
	
	
	
	
	//@RequestMapping("/addProductView.do")
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "forward:/product/addProductView.jsp";
	}
	

	
	
	//@RequestMapping("/addProduct.do")
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("product") Product product,
											MultipartHttpServletRequest mtfRequest) throws Exception {

		System.out.println("/product/addProduct : POST");

		//Business Logic
		product.setFileName(UploadFile.saveFile(mtfRequest.getFile("file"),uploadPath));
		System.out.println("파일확인 : "+product.getFileName());
		productService.addProduct(product);
		
		return "forward:/product/readProduct.jsp";
	}
	
	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , 
								@RequestParam("menu") String menu,
								@CookieValue(value="history", required=false)  Cookie cookie ,
								Model model,
								HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);	
		System.out.println("파일이름 확인 : "+product.getFileName());
		
		
			if ( cookie != null ) {
				if ( !(   cookie.getValue().contains(  Integer.toString(prodNo)   )   ) ) {
					cookie.setValue(   cookie.getValue()  +  Integer.toString(prodNo)  +  ","  );
					cookie.setPath("/");
					response.addCookie(  cookie  );
				}
			}else {
				cookie = new Cookie(  "history"  ,   Integer.toString(prodNo)+","   );
				cookie.setPath("/");
				response.addCookie(  cookie  );
			}
	
		return "forward:/product/getProduct.jsp";
//		}
	}
	
	
	
	
	
	//@RequestMapping("/updateProductView.do")
	@RequestMapping( value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo , Model model) throws Exception{

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	
	
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping( value="updateProduct" , method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product, Model model,
																					MultipartHttpServletRequest mtfRequest) throws Exception{

		System.out.println("/product/updateProduct : POST");
		//Business Logic
		product.setFileName(UploadFile.saveFile(mtfRequest.getFile("file"),uploadPath));
		boolean fileName = product.getFileName().endsWith("_");


		if ( fileName ) {
			product.setFileName((productService.getProduct(product.getProdNo())).getFileName());
		}
		
		productService.updateProduct(product);
		product = productService.getProduct(product.getProdNo());
		
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp?prodNo="+product.getProdNo();
	}
	
	
	
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping( value="listProduct" )
	public String listProduct( @ModelAttribute("search") Search search,
														@RequestParam("menu") String menu  ,
														Model model ) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST"+menu);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		System.out.println("■■■■■ 검색어 확인 : "+search.getSearchKeyword());
		System.out.println("■■■■■ 확인 : "+search);
		
		// Business logic 수행
		
		Map<String , Object> map=productService.getProductList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
			
		System.out.println("확인                                 :  "+map);
		System.out.println("확인     222                            :  "+map.get("list"));
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	


	
}