package com.gdu.smallmovietheater.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.smallmovietheater.domain.CartDTO;
import com.gdu.smallmovietheater.domain.ProductDTO;

@Mapper
public interface StoreMapper {
	
	public List<ProductDTO> productList();
	public ProductDTO productDetail(int productNo);
	
	// cart
	public int insertCart(CartDTO cartDTO);
	public List<CartDTO> selectCartList();
	public int updateCart(CartDTO cartDTO);
	public int deleteCart(List<String> cartNo);
}
