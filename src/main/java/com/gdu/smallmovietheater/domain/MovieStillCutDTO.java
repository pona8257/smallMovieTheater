package com.gdu.smallmovietheater.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MovieStillCutDTO {
  private int movieId;
  private int stillcutNo;
  private String stillcutName;
  private String stillcutDir;
  
}
