package com.gdu.smallmovietheater.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.smallmovietheater.service.UserService;

@RequestMapping("/user")
@Controller
public class UserController {
	
	// 필드
	@Autowired
	private UserService userService;
	
	// 약관동의 페이지
	@GetMapping("/agree.form")
	public String agreeForm() {
		return "user/agree";
	}
	
	// 회원가입 페이지
	@GetMapping("/join.form")
	public String joinForm(@RequestParam(value="location", required=false) String location  // 파라미터 location이 전달되지 않으면 빈 문자열("")이 String location에 저장된다.
	                     , @RequestParam(value="event", required=false) String event        // 파라미터 event가 전달되지 않으면 빈 문자열("")이 String event에 저장된다.
	    			     , Model model) {
		model.addAttribute("location", location);
		model.addAttribute("event", event);
		return "user/join";
	}
		
	@ResponseBody
	@GetMapping(value="/verifyId.do", produces="application/json")
	public Map<String, Object> verifyId(@RequestParam("userId") String userId) {
		return userService.verifyId(userId);
	}
	  
	  @ResponseBody
	  @GetMapping(value="/verifyEmail.do", produces="application/json")
	  public Map<String, Object> verifyEmail(@RequestParam("userEmail") String userEmail) {
	    return userService.verifyEmail(userEmail);
	  }
	  
	  @ResponseBody
	  @GetMapping(value="/sendAuthCode.do", produces="application/json")
	  public Map<String, Object> sendAuthCode(@RequestParam("userEmail") String userEmail) {
	    return userService.sendAuthCode(userEmail);
	  }
	
	@PostMapping("/join.do")
	  public void join(HttpServletRequest request, HttpServletResponse response) {
	    userService.join(request, response);
	  }
	
	// 로그인 페이지
	@GetMapping("/login.form")
	  public String loginForm(HttpServletRequest request, Model model) {
	    String url = request.getHeader("referer");
	    model.addAttribute("url", url == null ? request.getContextPath() : url);
	    return "user/login";
	  }
	@PostMapping("/login.do")
	 public void login(HttpServletRequest request, HttpServletResponse response) {
	    userService.login(request, response);
	  }
	@GetMapping("/logout.do")
	  public String logout(HttpServletRequest request, HttpServletResponse response) {
	    userService.logout(request, response);
	    return "redirect:/";
	  }
	@GetMapping("/mypage.do")
	  public String mypage(HttpSession session, Model model) {  // 마이페이지로 이동
	    String userId = (String) session.getAttribute("loginId");
	    model.addAttribute("loginUser", userService.getUserById(userId));
	    return "user/mypage";
	  }
	@GetMapping("/findId.form")  // 아이디 찾기 화면으로 이동
	  public String findIdForm() {
	    return "user/findId";
	  }
	
}
