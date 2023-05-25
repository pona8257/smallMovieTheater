package com.gdu.smallmovietheater.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.smallmovietheater.domain.MovieDTO;
import com.gdu.smallmovietheater.domain.MovieSearchDTO;
import com.gdu.smallmovietheater.service.MovieService;



@RequestMapping("/movie")
@Controller
public class MovieController {

  @Autowired
  private MovieService movieService;
  
  @GetMapping("/movielist.do")
  public String movielist(Model model) {
    List<MovieDTO> movieList = movieService.getMovieList();
    model.addAttribute("movieList", movieList);
    return "movie/movielist";
  }
  
  @GetMapping("/movieDetail.do")
  public String movieDetail(@RequestParam("movieId") int movieId, Model model) {
    movieService.getMovieDetail(movieId, model);
    return "movie/movieDetail";
  }
  
  @GetMapping("/movieposterdisplay.do")
  public ResponseEntity<byte[]> movieposterdisplay(@RequestParam("movieId") int movieId) {
    return movieService.getmovieposterdisplay(movieId);
  }
  
  @GetMapping("/sortingByRating.do")
  public String sortingByRating(Model model) {
    List<MovieDTO> ratingMovieList = movieService.getRatingByMovieList();
    model.addAttribute("ratingMovieList", ratingMovieList);
    return "movie/movielist";
  }
  
  @PostMapping("/addMovieReview.do")
  public String review(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("addResult", movieService.addReview(request));
    return "redirect:/movie/movieDetail.do?movieId=" + request.getParameter("movieId");
  }
  
  @ResponseBody
  @GetMapping(value="/searchMovie.do", produces="application/json")
  public Map<String, Object> searchMovie(MovieSearchDTO movieSearchDTO){
    return movieService.searchMovie(movieSearchDTO);
  }
  
  @PostMapping("/deleteMovieReview.do")
  public String deleteReview(@RequestParam("reviewNo") int reviewNo
                           , @RequestParam("movieId") int movieId
                           , RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("deleteResult", movieService.deleteReview(reviewNo));
    return "redirect:/movie/movieDetail.do?movieId=" + movieId;
  }
  
}
