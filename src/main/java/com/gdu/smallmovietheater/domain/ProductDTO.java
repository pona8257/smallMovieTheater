package com.gdu.smallmovietheater.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDTO {
   
   private int productNo;
   private String productName;
   private int price;
   private String productContent;
   private Date registration;
   private int count;
   private int removes;
   private String imagePath;
   private String imageName;
   
}