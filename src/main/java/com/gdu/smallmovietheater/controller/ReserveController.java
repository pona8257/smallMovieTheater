package com.gdu.smallmovietheater.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.smallmovietheater.domain.MovieDTO;
import com.gdu.smallmovietheater.service.ReservationService;

@Controller
@RequestMapping("/movie")
public class ReserveController {
	
	@Autowired
	private ReservationService reservationService;
	
	@GetMapping("/reserve.form")
	public String reserve() {
		return "/reserve/reservation";
	}
	
	@GetMapping(value="/date.do", produces="application/json")
	@ResponseBody
	public Map<String, Object> getDate(){
		return reservationService.getDate();
	}
	
	@GetMapping(value="/getMovieList.do", produces="application/json")
	@ResponseBody
	public Map<String, Object> getMovieList(){
		return reservationService.getMovieList();
	}
	
	@GetMapping(value="/reserveSelectMovie.do", produces="application/json")
	@ResponseBody
	public Map<String, Object> getMovieScreenDate(String title){
		return reservationService.getScreenDate(title);
	}
	
	@GetMapping(value="/searchScreenDate.do", produces="application/json")
	@ResponseBody
	public Map<String, Object> searchScreenDateMovie(String date){
		return reservationService.searchScreenDateMovie(date);
	}
	
	@GetMapping(value="/reserveSelectTime.do", produces="application/json")
	@ResponseBody
	public Map<String, Object> selectMovieAndTime(HttpServletRequest request){
		return reservationService.selectMovieByMovieAndTime(request);
	}
	
	@GetMapping(value="/getSeats.do", produces="application/json")
	@ResponseBody
	public Map<String, Object> getSeats(HttpServletRequest request){
		return reservationService.getScreenSeats(request);
	}
	
	@PostMapping(value="/reservation.do", produces="application/json")
	@ResponseBody
	public void reservation(HttpServletRequest request) {
		reservationService.reservation(request);
	}
	
	@PostMapping("/reserved.form")
	public String reservedInfo(HttpServletRequest request, Model model) {
		reservationService.selectReservedInfo(request, model);
		return "reserve/reservedInfo";
	}
	
}
