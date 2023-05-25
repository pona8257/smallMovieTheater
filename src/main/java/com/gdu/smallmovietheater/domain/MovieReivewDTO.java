package com.gdu.smallmovietheater.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MovieReivewDTO {
  private int movieId;
  private String userId;
  private int reviewNo;
  private String reviewContent;
  private double reviewRating;
  private String reviewDateAt;
}
