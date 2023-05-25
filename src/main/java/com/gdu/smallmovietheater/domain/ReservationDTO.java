package com.gdu.smallmovietheater.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReservationDTO {
  private int reservationNo;
  private int userNo;
  private ScreenDateDTO screenDateDTO;
  private MovieDTO movieDTO;
  private String reservationRow;
  private String reservationColumn;
  private String paymentOption;
  private String paymentCompany;
  private String paymentCardno;
  private int reservationStatus;
  private Date reservationAt;
  private int paymentTotalCost;
}
