package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	

	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	
	//===========================================================================
	
	@RequestMapping( value="json/login", method=RequestMethod.GET )
	public Map login() throws Exception{
		
		System.out.println("/user/logon : GET");
		
		Map map = new HashMap();
		map.put("message","loginOK");

		return map;
	}
	

	
	
	@RequestMapping( value="json/addUser", method=RequestMethod.GET )
	public Map addUser() throws Exception{
	
		System.out.println("/user/addUser : GET");
	
		Map map = new HashMap();
		map.put("message","addUserOK");
		
		return map;
	}
	
	
	//ok
	@RequestMapping( value="json/addUser", method=RequestMethod.POST )
	public Map addUser( @RequestBody User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		System.out.println("�����  1  : " +user);
		
		//Business Logic
		userService.addUser(user);
		Map map = new HashMap();
		map.put("message","ok");
		map.put("user", user);
		
		return map;
	}
	
	//get ok
	@RequestMapping( value="json/updateUser/{userId}", method=RequestMethod.GET )
	public User updateUser( @PathVariable String userId  ) throws Exception{

		System.out.println("/user/updateUser : GET");
		System.out.println("�����  1  : " +userId);
		
		//Business Logic
		//User user = userService.getUser(userId);
		return userService.getUser(userId);
	}
	
	//post
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST )
	public User updateUser(@RequestBody User user, HttpSession session) throws Exception{

		System.out.println("/user/updateUser : POST");
		System.out.println("�����  1  : " +user);
		System.out.println("�����  2  : " +session);
		System.out.println("�����  3  : " +session.getAttribute("user"));
		
		//Business Logic
		//String sessionId=((User)session.getAttribute("user")).getUserId();
		//if(sessionId.equals(user.getUserId())){
		//	session.setAttribute("user", user);
		//}
		userService.updateUser(user);
		System.out.println("�����  4  : " +user);
		
		return user;
	}
	
	//Ȯ��
	@RequestMapping( value="json/logout/{userId}", method=RequestMethod.GET )
	public Map logout(	@PathVariable String userId,  HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		System.out.println("�����  1  : " +userId);
		
		session.invalidate();
		
		Map map = new HashMap();
		map.put("message","ok");
		map.put("userId",userId);
		
		return map;
	}
	
	//Ȯ��
	@RequestMapping( value="json/checkDuplication/{userId}", method=RequestMethod.GET )
	public Map checkDuplication(@PathVariable String userId) throws Exception{
		
		System.out.println("/user/checkDuplication : POST");
		
		boolean result=userService.checkDuplication(userId);
		
		Map map = new HashMap();
		map.put("result",result);
		
		return map;
	}

	
	@RequestMapping( value="json/listUser" )
	public Map listUser( @RequestBody Search search ) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("message","userOK");
		//"forward:/user/listUser.jsp"
		
		return map;
	}
	
}