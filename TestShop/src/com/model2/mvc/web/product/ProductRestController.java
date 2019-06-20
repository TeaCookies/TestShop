package com.model2.mvc.web.product;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.protobuf.ByteString;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.UploadFile;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 판매관리 Controller
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	public ProductRestController(){
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
	
	
	
	// 비전테스트  //////////////////////////////////////////////////////////////////////////
	

    
	
	@RequestMapping( value="json/visionTest/{testtest}"  )
	public void visionTest(@PathVariable String testtest  ) throws FileNotFoundException, IOException {
        
		System.out.println("레스트 컨트롤러 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		/* base64 encoding */ 
		byte[] encoded = Base64.encodeBase64(testtest.getBytes()); 
		/* base64 decoding */ 
		byte[] decoded = Base64.decodeBase64(encoded); 
		System.out.println("인코딩 전 : " + testtest); 
		System.out.println("인코딩 text : " + new String(encoded)); 
		System.out.println("디코딩 text : " + new String(decoded));


            
		try {
			
			
			List<AnnotateImageRequest> requests = new ArrayList<>();
		
			ByteString imgBytes = ByteString.readFrom(new FileInputStream(new String(decoded)));
		
			Image img = Image.newBuilder().setContent(imgBytes).build();
			Feature feat = Feature.newBuilder().setType(Type.WEB_DETECTION).build();
			AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
			requests.add(request);
		
			try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
				System.out.println("리퀘스트 확인===========================\n"+client.batchAnnotateImages(requests));
				BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
				System.out.println("리퀘스트 확인=======================\n"
				+response.toString().substring(      (   response.toString().indexOf("description: ")   )   ,   (   response.toString().indexOf("}")   )  ));
				
			    List<AnnotateImageResponse> responses = response.getResponsesList();

			    
			    
		/////////////////////////////////	    
			    
//			    for (AnnotateImageResponse res : responses) {
//			    	if (res.hasError()) {
//			    		System.out.printf("Error: %s\n", res.getError().getMessage());
//			    		return;
//			    	}
		
//			    	System.out.println("Text : ");
//			    	System.out.println(res.TextgetTextAnnotationsList().get(0).getDescription());
//			    	System.out.println(res.getTextAnnotationsList().get(0).getDescription());
			      
			    	// For full list of available annotations, see http://g.co/cloud/vision/docs
			    	/*for (EntityAnnotation annotation : res.getTextAnnotationsList()) {
				    	  
						//System.out.printf("Text: %s\n", annotation.getDescription());
						//System.out.printf("Position : %s\n", annotation.getBoundingPoly());
					}*/
//			    }
		//////////////////////////////////
		
		
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
    }
        
 
    
    //required above jdk 1.7 - switch(String)
    private boolean isValidExtension(String originalName) {
        String originalNameExtension = originalName.substring(originalName.lastIndexOf(".") + 1);
        switch(originalNameExtension) {
        case "jpg":
        case "png":
        case "gif":
            return true;
        }
        return false;
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////
	
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.GET )
	public Map addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		Map map = new HashMap();
		map.put("message","addProduct OK");
		
		return map;
	}
	
	
	
	//확인
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public Map addUser( @RequestBody Product product, MultipartHttpServletRequest mtfRequest ) throws Exception {

		System.out.println("/product/addProduct : POST");

		//Business Logic
		product.setFileName(UploadFile.saveFile(mtfRequest.getFile("file"),uploadPath));
		productService.addProduct(product);
		
		Map map = new HashMap();
		map.put("message","ok");
		map.put("product", product);
		
		return map;
	}
	


	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Product getProduct( @PathVariable int prodNo , 
								@CookieValue(value="history", required=false)  Cookie cookie ,
								HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		//Business Logic
		// Model 과 View 연결
		
		if ( cookie != null ) {
			if ( !( cookie.getValue().contains(Integer.toString(prodNo)) ) ) {
				cookie.setValue(cookie.getValue()+","+Integer.toString(prodNo));
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		}else {
			response.addCookie(new Cookie("history", Integer.toString(prodNo)));
		}
	

		return productService.getProduct(prodNo);
	}
	
	

	@RequestMapping( value="json/updateProduct/{prodNo}", method=RequestMethod.GET)
	public Product updateProduct( @PathVariable  int prodNo ) throws Exception{

		System.out.println("/product/updateProductView : GET");
		System.out.println("■■■■ 확인 : "+prodNo);
		//Business Logic
		
		return productService.getProduct(prodNo);
	}
	
	

	@RequestMapping( value="json/updateProduct" , method=RequestMethod.POST)
	public Product updateProduct( @RequestBody Product product) throws Exception{

		System.out.println("/product/updateProduct : POST");
		System.out.println("■■■■ 확인 : "+product.getProdNo());
		//Business Logic

		productService.updateProduct(product);

		
		return product;
	}
	
	

	@RequestMapping( value="json/listProduct" )
	public Map listProduct(@RequestBody  Search search ) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("message","prodOK");
		
		return map;
	}
	
	
}