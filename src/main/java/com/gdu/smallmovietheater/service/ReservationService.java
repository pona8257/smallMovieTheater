package com.gdu.smallmovietheater.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;


public interface ReservationService {
	
	public Map<String, Object> getDate();
	public Map<String, Object> getMovieList();
	public Map<String, Object> getScreenDate(String title);
	public Map<String, Object> searchScreenDateMovie(String date);
	public Map<String, Object> selectMovieByMovieAndTime(HttpServletRequest request);
	public Map<String, Object> getScreenSeats(HttpServletRequest request);
	public void reservation(HttpServletRequest request);
	public void selectReservedInfo(HttpServletRequest request, Model model);
	
}
