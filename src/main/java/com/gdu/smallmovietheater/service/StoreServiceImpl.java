package com.gdu.smallmovietheater.service;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.smallmovietheater.domain.CartDTO;
import com.gdu.smallmovietheater.domain.ProductDTO;
import com.gdu.smallmovietheater.mapper.StoreMapper;

@Service
public class StoreServiceImpl implements StoreService {

	@Autowired
	private StoreMapper storeMapper;
	
	@Override
	public List<ProductDTO> products() {
		List<ProductDTO> products = storeMapper.productList();
		return products;
	}
	
	@Override
	public ProductDTO detail(int productNo) {
		ProductDTO productDTO = storeMapper.productDetail(productNo);
		return productDTO;
	}
	
	@Override
	public int insertCart(HttpServletRequest request) {
		int count = Integer.parseInt(request.getParameter("count"));
		CartDTO cartDTO = new CartDTO();
		ProductDTO productDTO = new ProductDTO();
		productDTO.setProductNo(Integer.parseInt(request.getParameter("productNo")));
		cartDTO.setProductDTO(productDTO);
		cartDTO.setCount(count);
		/*
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("loginId");
		cartDTO.setUserId(userId);
		*/
		
	
		int insertResult = storeMapper.insertCart(cartDTO);
		return insertResult;
	}
	
	@Override
	public List<CartDTO> selectCartList(HttpServletRequest request, Model model) {
		/*
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("loginId");
		*/
		
		List<CartDTO> carts = storeMapper.selectCartList();
		int totalPrice = 0;
		int totalCount = 0;
		for(int i = 0; i < carts.size(); i++) {
			for(int y = 0; y < carts.get(i).getCount(); y++) {
				totalPrice += carts.get(i).getProductDTO().getPrice();
				totalCount++;
			}
		}
		
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("cartsCount", totalCount);
		return carts;
	}
	
	@Override
	public void removeCart(HttpServletRequest request, HttpServletResponse response) {
		
		String[] cartNo = request.getParameterValues("cartNo");
		
		int removeResult = storeMapper.deleteCart(Arrays.asList(cartNo));
		
		try {	
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			if(removeResult == cartNo.length) {
				out.println("alert('선택된 모든 상품이 삭제되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/store/cart.form'");
			} else {
				out.println("alert('선택된 상품이 삭제되지 않았습니다.')");
				out.println("location.href='" + request.getContextPath() + "/store/cart.form'");
			}
			out.println("</script>");
			out.flush();
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int insertOrder() {
		
		
		storeMapper.insertOrder(null);
		
		return 0;
	}
	
	
	
	
	
	
	
	
	
	
}
