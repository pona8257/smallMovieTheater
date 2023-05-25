package com.gdu.smallmovietheater.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailDTO {
   
   private int orderDetailNo;
   private OrderDTO orderDTO;
   private CartDTO cartDTO;
   private CouponDTO couponDTO;
   private ProductDTO productDTO;
   
}