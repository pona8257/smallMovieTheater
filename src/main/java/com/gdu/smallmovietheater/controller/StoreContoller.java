package com.gdu.smallmovietheater.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.smallmovietheater.service.StoreService;

@RequestMapping("/store")
@Controller
public class StoreContoller {
	
	@Autowired
	private StoreService storeService;
	
	@GetMapping("/store.do")
	public String store(Model model) {
		model.addAttribute("products", storeService.products());
		return "store/store";
	}
	
	
	@GetMapping("/detail.do")
	public String detail(@RequestParam("productNo") int productNo,
						Model model) {
		model.addAttribute("product", storeService.detail(productNo));
		return "store/detail";
	}
	
	
	@PostMapping("/cart.do")
	public String cart(HttpServletRequest request, RedirectAttributes redirectAttributes ) {
		redirectAttributes.addFlashAttribute("insertResult", storeService.insertCart(request));
		return "redirect:/store/store.do";
	}
	
	@GetMapping("/cart.form")
	public String cart_form(HttpServletRequest request, Model model) {
		model.addAttribute("carts", storeService.selectCartList(request, model));
		return "store/cart";
	}
	
	@GetMapping("/paymentDetail.do")
	public String payment(HttpServletRequest request, Model model) {
		
		return "store/payment";
	}
	
	@PostMapping("/remove.do")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		
		
		
		storeService.removeCart(request, response);
		
	}
	
}
