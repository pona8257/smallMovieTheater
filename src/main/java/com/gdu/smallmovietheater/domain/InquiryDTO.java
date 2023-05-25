package com.gdu.smallmovietheater.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InquiryDTO {
  private int inguiryNo;
  private String contentType;
  private String inguiryTitle;
  private String inguiryContent;
  private String path;
  private Date createdAt;
  
}
