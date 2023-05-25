package com.gdu.smallmovietheater.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeDTO {
  private int noticeNo;
  private String noticeTitle;
  private Date registraintDate;
  private String content;
  
}
