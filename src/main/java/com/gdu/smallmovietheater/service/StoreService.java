package com.gdu.smallmovietheater.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.gdu.smallmovietheater.domain.CartDTO;
import com.gdu.smallmovietheater.domain.ProductDTO;

public interface StoreService {
	
	// store.do
	public List<ProductDTO> products();
	// detail.do
	public ProductDTO detail(int productNo);
	//cart.do
	public int insertCart(HttpServletRequest request);
	// cart.form
	public List<CartDTO> selectCartList(HttpServletRequest request, Model model);
	
	//remove.do
	public void removeCart(HttpServletRequest request, HttpServletResponse response);
}
