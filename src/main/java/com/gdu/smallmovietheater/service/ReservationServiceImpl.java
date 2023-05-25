package com.gdu.smallmovietheater.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.gdu.smallmovietheater.domain.MovieDTO;
import com.gdu.smallmovietheater.domain.ReservationDTO;
import com.gdu.smallmovietheater.domain.ScreenDateDTO;
import com.gdu.smallmovietheater.mapper.ReserveMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor 
public class ReservationServiceImpl implements ReservationService {
	
	private final ReserveMapper reserveMapper;
	
	@Override
	public Map<String, Object> getDate() {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> list = reserveMapper.getDate();
		
		map.put("dateList", list);
		
		return map;
	}
	
	@Override
	public Map<String, Object> getMovieList() {
		
		List<MovieDTO> list = reserveMapper.getMovieList();
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("movieList", list);
		
		return map;
	}
	
	@Override
	public Map<String, Object> getScreenDate(String title) {

		List<ScreenDateDTO> list = reserveMapper.getScreenDate(title);
		Map<String, Object> map = new HashMap<String, Object>();
//		List<String> timeList = new ArrayList<String>();
//		String screenTime = "";
//		int runT = 0;
//		
//		for(int i = 0; i < list.size(); i++) {
//			screenTime = list.get(i).getScreenTime();
//			String arr[] = screenTime.split(":");
//			runT = list.get(i).getMovieDTO().getRunningtime();
//			if(runT / 60 != 0) {
//				arr[0] = (Integer.parseInt(arr[0])+runT/60)+"";
//			} else {
//				arr[1] = (Integer.parseInt(arr[1])+runT%60)+"";
//			}
//		}
		
		
		map.put("dateList", list);
		
		return map;
	}
	
	@Override
	public Map<String, Object> searchScreenDateMovie(String date) {
		List<MovieDTO> list = reserveMapper.searchScreenDateMovie(date);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("screenDateMovie", list);
		
		return map;
	}
	
	@Override
	public Map<String, Object> selectMovieByMovieAndTime(HttpServletRequest request) {

		Map<String, Object> map = new HashMap<String, Object>();
		
		String title = request.getParameter("title");
		String date = request.getParameter("date");
		String time = request.getParameter("time");
		
		ScreenDateDTO screenDateDTO = new ScreenDateDTO();
		MovieDTO movieDTO = new MovieDTO();
		movieDTO.setTitle(title);
		screenDateDTO.setScreenDate(date);
		screenDateDTO.setScreenTime(time);
		screenDateDTO.setMovieDTO(movieDTO);
		
	    ScreenDateDTO data = reserveMapper.selectMovieByMovieAndTime(screenDateDTO);
		map.put("data", data);
		
		return map;
	}
	
	@Override
	public Map<String, Object> getScreenSeats(HttpServletRequest request) {

		int seats[][] = new int[5][5];
		Map<String, Object> map = new HashMap<String, Object>();
		
		String movieId = request.getParameter("movieId");
		String screenDateNo = request.getParameter("screenDateNo");
		
		ReservationDTO reservationDTO = new ReservationDTO();
		MovieDTO movieDTO = new MovieDTO();
		ScreenDateDTO screenDateDTO = new ScreenDateDTO();
		movieDTO.setMovieId(Integer.parseInt(movieId));
		screenDateDTO.setScreenDateNo(Integer.parseInt(screenDateNo));
		reservationDTO.setMovieDTO(movieDTO);
		reservationDTO.setScreenDateDTO(screenDateDTO);
		
		Map<String, Object> ruquestMap = new HashMap<String, Object>();
		ruquestMap.put("movieId", movieId);
		ruquestMap.put("screenDateNo", screenDateNo);
		
		List<ReservationDTO> list = reserveMapper.getSeats(ruquestMap);
		List<int[][]> seatList = new ArrayList<int[][]>();
		if (list == null) {
		    for (int i = 0; i < 5; i++) {
		        for (int j = 0; j < 5; j++) {
		            seats[i][j] = 0;
		        }
		    }
		    seatList.add(seats);
		} else {
		    // 초기화
		    for (int i = 0; i < 5; i++) {
		        for (int j = 0; j < 5; j++) {
		            seats[i][j] = 0;
		        }
		    }

		    // 예약된 좌석 표시
		    for (ReservationDTO rsvDTO : list) {
		        int row = Integer.parseInt(rsvDTO.getReservationRow()) - 1;
		        int column = Integer.parseInt(rsvDTO.getReservationColumn()) - 1;
		        seats[row][column] = 1;
		    }

		    seatList.add(seats);
		}

		map.put("seatData", seats);
		
		return map;
	}
	
	@Override
	public void reservation(HttpServletRequest request) {
		
		ReservationDTO reservationDTO = new ReservationDTO();
		ScreenDateDTO screenDateDTO = new ScreenDateDTO();
		MovieDTO movieDTO = new MovieDTO();
		
		String userNo = request.getParameter("userNo");
		String movieId = request.getParameter("movieId");
		String screenDateNo = request.getParameter("screenDateNo");
		String paymentTotalCost = request.getParameter("paymentTotalCost");
		String row = request.getParameter("row");
		String column = request.getParameter("column");
		String paymentOption = request.getParameter("paymentOption");
		
		screenDateDTO.setScreenDateNo(Integer.parseInt(screenDateNo));
		movieDTO.setMovieId(Integer.parseInt(movieId));
		
		reservationDTO.setUserNo(Integer.parseInt(userNo));
		reservationDTO.setScreenDateDTO(screenDateDTO);
		reservationDTO.setMovieDTO(movieDTO);
		reservationDTO.setReservationRow(row);
		reservationDTO.setReservationColumn(column);
		reservationDTO.setPaymentOption(paymentOption);
		reservationDTO.setPaymentTotalCost(Integer.parseInt(paymentTotalCost));
		
		int reservationResult = reserveMapper.reservation(reservationDTO);
		try {
			
		} catch (Exception e) {
			
		}
	}
	
}
