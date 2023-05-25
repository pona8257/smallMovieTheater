package com.gdu.smallmovietheater.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smallmovietheater.domain.MovieDTO;
import com.gdu.smallmovietheater.domain.MovieReivewDTO;
import com.gdu.smallmovietheater.domain.MovieSearchDTO;



@Mapper
public interface MovieMapper {

  public List<MovieDTO> getMovieList();
  public List<MovieDTO> getgetRatingByMovieList();
  public MovieDTO getMovieDetail(int movieId);
  public int insertReview(MovieReivewDTO movieReivewDTO);
  public List<MovieReivewDTO> getMovieReview(int movieId);
  public List<MovieDTO> getMovieByColumn(MovieSearchDTO movieSearchDTO);
  public int deleteReviewByNo(int reviewNo);
}
