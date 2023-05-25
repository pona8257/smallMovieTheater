package com.gdu.smallmovietheater.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartDTO {

   private int cartNo;
   private int count;
   private String userId;
   private ProductDTO productDTO;
   
}