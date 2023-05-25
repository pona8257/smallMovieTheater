package com.gdu.smallmovietheater.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

import com.gdu.smallmovietheater.domain.MovieDTO;
import com.gdu.smallmovietheater.domain.MovieReivewDTO;
import com.gdu.smallmovietheater.domain.MovieSearchDTO;
import com.gdu.smallmovietheater.mapper.MovieMapper;

@Service
public class MovieServiceImpl implements MovieService {

  @Autowired
  private MovieMapper movieMapper;
  
  @Override
  public List<MovieDTO> getMovieList() {
    List<MovieDTO> movieList = movieMapper.getMovieList();
    
    return movieList;
  }
  
  @Override
  public void getMovieDetail(int movieId, Model model) {
    MovieDTO movieDetail = movieMapper.getMovieDetail(movieId);
    List<MovieReivewDTO> movieReviewList = movieMapper.getMovieReview(movieId);
    model.addAttribute("movieDetail", movieDetail);
    model.addAttribute("movieReviewList", movieReviewList);
  }

  @Override
  public ResponseEntity<byte[]> getmovieposterdisplay(int movieId) {
    MovieDTO movieDTO = movieMapper.getMovieDetail(movieId);
    ResponseEntity<byte[]> image = null;
    try {
      File movieposter = new File(movieDTO.getPosterPath(), movieDTO.getPosterName());
      image = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(movieposter), HttpStatus.OK);    
    } catch(Exception e) {
      e.printStackTrace();
    }
    return image;
  }
  
  @Override
  public List<MovieDTO> getRatingByMovieList() {
    List<MovieDTO> ratingMovieList = movieMapper.getgetRatingByMovieList();
    return ratingMovieList;
  }
  
  @Override
  public int addReview(HttpServletRequest request) {
    
    int movieId =Integer.parseInt(request.getParameter("movieId"));
    String reviewContent = request.getParameter("reviewContent");
    String userId = request.getParameter("userId");
    double reviewRating =Double.parseDouble(request.getParameter("reviewRating"));
    
    MovieReivewDTO board = new MovieReivewDTO();
    board.setMovieId(movieId);
    board.setUserId(userId);
    board.setReviewContent(reviewContent);
    board.setReviewRating(reviewRating);
    
    int addResult = movieMapper.insertReview(board);
    
    return addResult;
  }
  
  @Override
  public Map<String, Object> searchMovie(MovieSearchDTO MovieSearchDTO) {
    
    List<MovieDTO> list = movieMapper.getMovieByColumn(MovieSearchDTO);
    
    String message = null;
    if(list.isEmpty()) {
      message = MovieSearchDTO.getSearchText() + " 의 검색결과가 없습니다";
    } else {
      message = list.size() + "개의 검색 결과가 있습니다.";
    }
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("list", list);
    map.put("message", message);
    return map;
  }
  
  @Override
  public int deleteReview(int reviewNo) {
    int deleteResult = movieMapper.deleteReviewByNo(reviewNo);
    return deleteResult;
  }
  
}
