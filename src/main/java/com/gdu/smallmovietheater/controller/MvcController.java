package com.gdu.smallmovietheater.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MvcController {

  @GetMapping("/")
  public String welcom() {
    return "index";
  }
  

}
