package com.gdu.smallmovietheater.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.smallmovietheater.domain.MovieDTO;
import com.gdu.smallmovietheater.service.MovieService;

@Controller
public class MvcController {

  @Autowired
  private MovieService movieService;
  
  @GetMapping("/")
  public String welcom(Model model) {
    model.addAttribute("movieList", movieService.getRatingByMovieList());
    return "index";
  }
  

}
