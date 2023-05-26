package com.gdu.smallmovietheater.service;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.smallmovietheater.domain.CartDTO;
import com.gdu.smallmovietheater.domain.OrderDTO;
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
		
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		if(userId != null) {
			int count = Integer.parseInt(request.getParameter("count"));
			CartDTO cartDTO = new CartDTO();
			ProductDTO productDTO = new ProductDTO();
			productDTO.setProductNo(Integer.parseInt(request.getParameter("productNo")));
			cartDTO.setProductDTO(productDTO);
			cartDTO.setCount(count);
			cartDTO.setUserId(userId);
			
			int insertResult = storeMapper.insertCart(cartDTO);
			return insertResult;
			
		} else {
			return 0;
		}
		
	}
	
	@Override
	public List<CartDTO> selectCartList(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		List<CartDTO> carts = storeMapper.selectCartList(userId);
		int totalPrice = 0;
		int totalCount = 0;
		for(int i = 0; i < carts.size(); i++) {
			for(int y = 0; y < carts.get(i).getCount(); y++) {
				totalPrice += carts.get(i).getProductDTO().getPrice();
				totalCount++;
			}
		}
		
		String cartUp = request.getParameter("cartUp");
		String cartDown = request.getParameter("cartDown");
		if(cartUp != "") {
			totalCount++;
		} else if(cartDown != "") {
			totalCount--;
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
	
	@Transactional
	public int insertOrder(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		int userNo = (int)session.getAttribute("userNo");
		String userId = (String)session.getAttribute("userId");
		
		int insertResult = storeMapper.insertOrder(userNo);
		
		List<CartDTO> carts = storeMapper.selectCartList(userId);
		
		if(insertResult != 0) {
			List<OrderDTO> orders = storeMapper.selectOrder(userNo);
			if(carts.size() != 0) {
				storeMapper.deleteCartUser(userId);
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
				model.addAttribute("carts", carts);
			}
			model.addAttribute("orders", orders);
		} 
		
		return insertResult;
	}
	
	
	
	
	
	
	
	
	
	
}
