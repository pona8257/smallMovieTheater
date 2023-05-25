package com.gdu.smallmovietheater.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LeaveUserDTO {
  private String userId;
  private String userEmail;
  private Date joinedAt;
  private Date leaveAt;
}
