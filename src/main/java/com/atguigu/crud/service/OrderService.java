package com.atguigu.crud.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Order;
import com.atguigu.crud.bean.OrderExample;
import com.atguigu.crud.bean.OrderExample.Criteria;
import com.atguigu.crud.dao.OrderMapper;

@Service
public class OrderService {
	
	@Autowired
	private OrderMapper orderMapper;

	public List<Order> findAll() {
		List<Order> list = orderMapper.findAll();
		return list;
	}

	public List<Order> findByExample(String creator, Date dateGt, Date dateLt, String vendor) {
		List<Order> list = orderMapper.findByExample(creator, dateGt, dateLt, vendor);
		return list;
	}

	public void insertOrder(Order order) {
		orderMapper.insertOrder(order);
	}

	/**
	 * 批量删除
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		OrderExample example = new OrderExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdIn(ids);
		orderMapper.deleteByExample(example);
	}

	/**
	 * 单个删除
	 * @param id
	 */
	public void deleteById(Integer id) {
		orderMapper.deleteById(id);
	}

	/**
	 * 更新
	 */
	public void updateOrder(Order order) {
		orderMapper.updateByPrimaryKeySelective(order);
	}

	public Order getOrderById(Integer id) {
		Order order = orderMapper.selectByPrimaryKey(id);
		return order;
	}

	/**
	 * 查询最大id+1
	 */
	public int findMaxId() {
		HashMap<String, Object> map = orderMapper.findMaxId();
		if(map ==null){
			return 1;
		}
		Object object = map.get("id");
		return Integer.parseInt(object.toString())+1;
	}
}
