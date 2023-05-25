package com.gdu.smallmovietheater.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CouponDTO {
   
   private int couponNo;
   private String couponName;
   private int sale;
   private Date startDate;
   private Date endDate;
   
}
