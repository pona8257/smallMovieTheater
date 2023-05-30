package com.gdu.smallmovietheater.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smallmovietheater.domain.MovieDTO;
import com.gdu.smallmovietheater.domain.ReservationDTO;
import com.gdu.smallmovietheater.domain.ScreenDateDTO;


@Mapper
public interface ReserveMapper {

	public List<String> getDate();
	public List<MovieDTO> getMovieList();
	public List<ScreenDateDTO> getScreenDate(String title);
	public List<MovieDTO> searchScreenDateMovie(String date);
	public ScreenDateDTO selectMovieByMovieAndTime(ScreenDateDTO screenDateDTO);
	public List<ReservationDTO> getSeats(Map<String, Object> map);
	public int reservation(ReservationDTO reservationDTO);
	public ReservationDTO selectReservedInfo(ReservationDTO reservationDTO);
}
