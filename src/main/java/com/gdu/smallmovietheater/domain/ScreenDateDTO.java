package com.gdu.smallmovietheater.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ScreenDateDTO {
  private int screenDateNo;
  private MovieDTO movieDTO;
  private String screenDate;
  private String screenTime;
  private double discountPct;
}