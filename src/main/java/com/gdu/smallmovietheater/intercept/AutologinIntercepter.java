package com.gdu.smallmovietheater.intercept;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import com.gdu.smallmovietheater.domain.UserDTO;
import com.gdu.smallmovietheater.mapper.UserMapper;

@Component
public class AutologinIntercepter implements HandlerInterceptor {

  
   
  @Autowired
  private UserMapper userMapper;
  
  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    HttpSession session = request.getSession();
    
    if(session != null && session.getAttribute("userId") == null) {  // 로그인이 되어 있는가?
      
      Cookie cookie = WebUtils.getCookie(request, "autologinId");
      
      if(cookie != null) {  // 쿠키 autologinId가 존재하는가?
        
        String autologinId = cookie.getValue();
        UserDTO loginUserDTO = userMapper.selectAutologin(autologinId);
        if(loginUserDTO != null) {
          session.setAttribute("userId", loginUserDTO.getUserId());
        }
        
      }
      
    }
    
    return true;  // 인터셉터를 동작 시킨 뒤 컨트롤러를 계속 동작시킨다.
    
  }
  
}
