package com.gdu.smallmovietheater.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaymentDTO {
   
   private String itemNo;
   private int userNo;
   private int orderNo;
   private int paymentPrice;
   private Date paymentDate;
   private int priceOption;
   
}

