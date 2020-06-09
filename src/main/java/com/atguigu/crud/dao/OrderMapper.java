package com.atguigu.crud.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.atguigu.crud.bean.Order;
import com.atguigu.crud.bean.OrderExample;

public interface OrderMapper {
    long countByExample(OrderExample example);

    int deleteByExample(OrderExample example);


    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);

    Order selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByExample(@Param("record") Order record, @Param("example") OrderExample example);

	int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

	/**
	 * 查询所有提货单
	 * @return
	 */
	List<Order> findAll();

	/**
	 * 保存提货单
	 * @param order
	 */
	void insertOrder(Order order);

	int deleteById(Integer id);

	List<Order> findByExample(@Param("creator") String creator, @Param("dateGt") Date dateGt, @Param("dateLt") Date dateLt, @Param("vendor") String vendor);

	HashMap<String, Object> findMaxId();
}