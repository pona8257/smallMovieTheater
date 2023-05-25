package com.gdu.smallmovietheater.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MovieDTO {
  private int movieId;
  private String title;
  private String genre;
  private String director;
  private String startDate;
  private int runningtime;
  private String plot;
  private double rating;
  private String posterPath;
  private String posterName;
}
