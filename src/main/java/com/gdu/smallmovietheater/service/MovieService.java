package com.gdu.smallmovietheater.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;

import com.gdu.smallmovietheater.domain.MovieDTO;
import com.gdu.smallmovietheater.domain.MovieSearchDTO;

public interface MovieService {
  public List<MovieDTO> getMovieList();
  public void getMovieDetail(int movieId, Model model);
  public ResponseEntity<byte[]> getmovieposterdisplay(int movieId);
  public List<MovieDTO> getRatingByMovieList();
  public int addReview(HttpServletRequest request);
  public Map<String, Object> searchMovie(MovieSearchDTO MovieSearchDTO);
  public int deleteReview(int reviewNo);
}
