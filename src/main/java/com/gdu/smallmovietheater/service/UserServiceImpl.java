package com.gdu.smallmovietheater.service;

import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.smallmovietheater.domain.LeaveUserDTO;
import com.gdu.smallmovietheater.domain.UserDTO;
import com.gdu.smallmovietheater.mapper.UserMapper;
import com.gdu.smallmovietheater.util.JavaMailUtil;
import com.gdu.smallmovietheater.util.SecurityUtil;

import lombok.AllArgsConstructor;
@AllArgsConstructor
@Service
public class UserServiceImpl implements UserService {
	
	// 필드
	private UserMapper userMapper;
	private JavaMailUtil javaMailUtil;
	private SecurityUtil securityUtil;

	@Override
	public Map<String, Object> verifyId(String userId) {
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("enableId", userMapper.selectUserById(userId) == null && userMapper.selectSleepUserById(userId) == null && userMapper.selectLeaveUserById(userId) == null);
	    return map;
	    
	}
	
	@Override
	  public Map<String, Object> verifyEmail(String userEmail) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("enableEmail", userMapper.selectUserByEmail(userEmail) == null && userMapper.selectSleepUserByEmail(userEmail) == null && userMapper.selectLeaveUserByEmail(userEmail) == null);
	    return map;
	}

	@Override
	public Map<String, Object> sendAuthCode(String userEmail) {
		
		 // 사용자에게 전송할 인증코드 6자리
	    String authCode = securityUtil.getRandomString(6, true, true);  // 6자리, 문자사용, 숫자사용
	    
	    // 사용자에게 메일 보내기
	    javaMailUtil.sendJavaMail(userEmail, "[앱이름] 인증요청", "인증번호는 <strong>" + authCode + "</strong>입니다.");
	    
	    // 사용자에게 전송한 인증코드를 join.jsp로 응답
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("authCode", authCode);
	    return map;
	}

	@Override
	public void join(HttpServletRequest request, HttpServletResponse response) {
		
		// 요청 파라미터
	    String userId = request.getParameter("userId");
	    String userPassword = request.getParameter("userPassword");
	    String userName = request.getParameter("userName");
	    String userGender = request.getParameter("userGender");
	    String userEmail = request.getParameter("userEmail");
	    String userMobile = request.getParameter("userMobile");
	    String userBirthyear = request.getParameter("userBirthyear");
	    String userBirthmonth = request.getParameter("userBirthmonth");
	    String userBirthdate = request.getParameter("userBirthdate");
	    String postcode = request.getParameter("postcode");
	    String roadAddress = request.getParameter("roadAddress");
	    String jibunAddress = request.getParameter("jibunAddress");
	    String detailAddress = request.getParameter("detailAddress");
	    String extraAddress = request.getParameter("extraAddress");
	    String location = request.getParameter("location");
	    String event = request.getParameter("event");
	    
	    // 비밀번호 SHA-256 암호화
	    userPassword = securityUtil.getSha256(userPassword);

	    
	    // 이름 XSS 처리
		userName = securityUtil.preventXSS(userName);
	    
	    // 출생월일
	    userBirthdate = userBirthmonth + userBirthdate;
	    
	    // 상세주소 XSS 처리
	    detailAddress = securityUtil.preventXSS(detailAddress);
	    
	    // 참고항목 XSS 처리
	    extraAddress = securityUtil.preventXSS(extraAddress);
	    
	    // agreecode
	    int agreecode = 0;
	    if(location.isEmpty() == false && event.isEmpty() == false) {
	      agreecode = 3;
	    } else if(location.isEmpty() && event.isEmpty() == false) {
	      agreecode = 2;
	    } else if(location.isEmpty() == false && event.isEmpty()) {
	      agreecode = 1;
	    }
	    
	    // UserDTO 만들기
	    UserDTO userDTO = new UserDTO();
	    userDTO.setUserId(userId);
	    userDTO.setUserPassword(userPassword);
	    userDTO.setUserName(userName);
	    userDTO.setUserGender(userGender);
	    userDTO.setUserEmail(userEmail);
	    userDTO.setUserMobile(userMobile);
	    userDTO.setUserBirthyear(userBirthyear);
	    userDTO.setUserBirthdate(userBirthdate);
	    userDTO.setPostcode(postcode);
	    userDTO.setRoadAddress(roadAddress);
	    userDTO.setJibunAddress(jibunAddress);
	    userDTO.setDetailAddress(detailAddress);
	    userDTO.setExtraAddress(extraAddress);
	    userDTO.setAgreecode(agreecode);
	    
	    // 회원가입(UserDTO를 DB로 보내기)
	    int joinResult = userMapper.insertUser(userDTO);
	    
	    // 응답
	    try {
	      
	      response.setContentType("text/html; charset=UTF-8");
	      PrintWriter out = response.getWriter();
	      out.println("<script>");
	      if(joinResult == 1) {
	        out.println("alert('회원 가입되었습니다.');");
	        out.println("location.href='" + request.getContextPath() + "/index.do';");
	      } else {
	        out.println("alert('회원 가입에 실패했습니다.');");
	        out.println("history.go(-2);");
	      }
	      out.println("</script>");
	      out.flush();
	      out.close();
	      
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    
	  }

	@Override
	public void login(HttpServletRequest request, HttpServletResponse response) {
		
		// 요청 파라미터
	    String url = request.getParameter("url");  // 로그인 화면의 이전 주소(로그인 후 되돌아갈 주소)
	    String userId = request.getParameter("userId");
	    String userPassword = request.getParameter("userPassword");
	    
	    // 비밀번호 SHA-256 암호화
	    userPassword = securityUtil.getSha256(userPassword);
	    
	    // UserDTO 만들기
	    UserDTO userDTO = new UserDTO();
	    userDTO.setUserId(userId);
	    userDTO.setUserPassword(userPassword);
	    
	    // DB에서 UserDTO 조회하기
	    UserDTO loginUserDTO = userMapper.selectUserByUserDTO(userDTO);
	    
	    // ID, PW가 일치하는 회원이 있으면 로그인 성공
	    // 0. 자동 로그인 처리하기(autologin 메소드에 맡기기)
	    // 1. session에 ID 저장하기
	    // 2. 회원 접속 기록 남기기
	    // 3. 이전 페이지로 이동하기
	    if(loginUserDTO != null) {
	      
	      // 자동 로그인 처리를 위한 autologin 메소드 호출하기
	      autologin(request, response);
	      
	      HttpSession session = request.getSession();
	      session.setAttribute("userId", userId);
	      session.setAttribute("userNo", loginUserDTO.getUserNo());
	     
	      
	      int updateResult = userMapper.updateUserAccess(userId);
	      if(updateResult == 0) {
	        userMapper.insertUserAccess(userId);
	      }
	      
	      try {
	        response.sendRedirect(url);
	      } catch (Exception e) {
	        e.printStackTrace();
	      }
	      
	    }
	    // ID, PW가 일치하는 회원이 없으면 로그인 실패
	    else {
	      
	      // 응답
	      try {
	        
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('일치하는 회원 정보가 없습니다.');");
	        out.println("location.href='" + request.getContextPath() + "/';");
	        out.println("</script>");
	        out.flush();
	        out.close();
	        
	      } catch (Exception e) {
	        e.printStackTrace();
	      }
	      
	    }
	    
	  }
	
	@Override
	public void autologin(HttpServletRequest request, HttpServletResponse response) {
	
		 // 요청 파라미터
	    String userId = request.getParameter("userId");
	    String chkAutologin = request.getParameter("chkAutologin");
	    
	    // 자동 로그인을 체크한 경우
	    if(chkAutologin != null) {
	      
	      // session의 id를 가져온다.
	      HttpSession session = request.getSession();
	      String sessionId = session.getId();  // sessionId : 브라우저가 새롭게 열릴때마다 자동으로 갱신되는 임의의 값
	      
	      // DB로 보낼 UserDTO 만들기
	      UserDTO userDTO = new UserDTO();
	      userDTO.setUserId(userId);
	      userDTO.setAutologinId(sessionId);
	      userDTO.setAutologinExpiredAt(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 15));
	                                    // 현재 + 15일 : java.sql.Date 클래스를 이용해서 작업을 수행한다.
	                                    // java.sql.Date 클래스는 타임스탬프를 이용해서 날짜를 생성한다.
	      
	      // DB로 UserDTO 보내기
	      userMapper.insertAutologin(userDTO);
	      
	      // session id를 쿠키에 저장하기
	      Cookie cookie = new Cookie("autologinId", sessionId);
	      cookie.setMaxAge(60 * 60 * 24 * 15);      // 초 단위로 15일 지정
	      cookie.setPath(request.getContextPath()); // 애플리케이션의 모든 URL에서 autologinId 쿠키를 확인할 수 있다.
	      response.addCookie(cookie);
	      
	    }
	    // 자동 로그인을 체크하지 않은 경우
	    else {
	      
	      // DB에서 AUTOLOGIN_ID 칼럼과 AUTOLOGIN_EXPIRED_AT 칼럼 정보 삭제하기
	      userMapper.deleteAutologin(userId);
	      
	      // autologinId 쿠키 삭제하기
	      Cookie cookie = new Cookie("autologinId", "");
	      cookie.setMaxAge(0);                       // 쿠키 유지시간을 0초로 설정
	      cookie.setPath(request.getContextPath());  // autologinId 쿠키의 path와 동일하게 설정
	      response.addCookie(cookie);
	      
	    }
	    
	  }
		
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		
		// 1. 자동 로그인을 해제한다.
	    
	    // DB에서 AUTOLOGIN_ID 칼럼과 AUTOLOGIN_EXPIRED_AT 칼럼 정보 삭제하기
	    HttpSession session = request.getSession();
	    String userId = (String) session.getAttribute("userId");
	    userMapper.deleteAutologin(userId);
	    
	    // autoLoginId 쿠키 삭제하기
	    Cookie cookie = new Cookie("autologinId", "");
	    cookie.setMaxAge(0);                       // 쿠키 유지시간을 0초로 설정
	    cookie.setPath(request.getContextPath());  // autologinId 쿠키의 path와 동일하게 설정
	    response.addCookie(cookie);
	    
	    // 2. session에 저장된 모든 정보를 지운다.
	    session.invalidate();
	    
	  }

	@Transactional(readOnly=true)
	@Override
	public void leave(HttpServletRequest request, HttpServletResponse response) {
		// 탈퇴할 회원의 ID는 session에 loginId 속성으로 저장되어 있다.
	    HttpSession session = request.getSession();
	    String userId = (String) session.getAttribute("userId");
	    
	    // 탈퇴할 회원의 정보(ID, EMAIL, JOINED_AT) 가져오기
	    UserDTO userDTO = userMapper.selectUserById(userId);
	    
	    // LeaveUserDTO 만들기
	    LeaveUserDTO leaveUserDTO = new LeaveUserDTO();
	    leaveUserDTO.setUserId(userId);
	    leaveUserDTO.setUserEmail(userDTO.getUserEmail());
	    leaveUserDTO.setJoinedAt(userDTO.getJoinedAt());
	    
	    // 회원 탈퇴하기
	    int insertResult = userMapper.insertLeaveUser(leaveUserDTO);
	    int deleteResult = userMapper.deleteUser(userId);
	    
	    // 응답
	    try {
	      
	      response.setContentType("text/html; charset=UTF-8");
	      PrintWriter out = response.getWriter();
	      out.println("<script>");
	      if(insertResult == 1 && deleteResult == 1) {
	        
	        // session 초기화
	        session.invalidate();
	        
	        out.println("alert('회원 탈퇴되었습니다.');");
	        out.println("location.href='" + request.getContextPath() + "/index.do';");
	        
	      } else {
	        out.println("alert('회원 탈퇴에 실패했습니다.');");
	        out.println("history.back();");
	      }
	      out.println("</script>");
	      out.flush();
	      out.close();
	      
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    
	  }

	@Override
	public void mypage(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub

	}

	@Override
	public void sleepUserHandle() {
		// TODO Auto-generated method stub

	}
	
	@Override
	  public boolean checkPw(String userId, String userPassword) {
	    UserDTO userDTO = userMapper.selectUserById(userId);
	    userPassword = securityUtil.getSha256(userPassword);
	    return userPassword.equals(userDTO.getUserPassword());
	  }
	
	@Override
	  public UserDTO getUserById(String userId) {
	    return userMapper.selectUserById(userId);
	  }
	
	@Override
	public void restore(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}
	
	
    @Override public Map<String, Object> findUser(UserDTO userDTO) { 
    Map<String,Object> map = new HashMap<String, Object>(); 
    map.put("findUser", userMapper.selectUserByEmail(userDTO.getUserEmail())); 
    return map; 
    
    }
	   
}
