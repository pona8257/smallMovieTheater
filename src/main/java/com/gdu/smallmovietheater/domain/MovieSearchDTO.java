package com.gdu.smallmovietheater.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MovieSearchDTO {

 private String column;
 private String searchText;

}
