package com.atguigu.crud.test;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Order;
import com.atguigu.crud.bean.OrderExample;
import com.atguigu.crud.bean.OrderExample.Criteria;
import com.atguigu.crud.dao.OrderMapper;

/**
 * 测试dao层的工作
 * @author lfy
 *推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 *1、导入SpringTest模块
 *2、@ContextConfiguration指定Spring配置文件的位置
 *3、直接autowired要使用的组件即可
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	OrderMapper orderMapper;
	
	
	@Autowired
	SqlSession sqlSession;
	

	/**
	 * 测试DepartmentMapper
	 */
	@Test
	public void testFindAll() {
		List<Order> orders = orderMapper.findAll();
		if (orders != null && orders.size() > 0) {
			for (Order order : orders) {
				System.err.println(order.toString());
			}
		}
	}

	@Test
	public void testInser() {
		try {
			orderMapper.insertOrder(new Order(1, new Date(), "钉宫新路1", 10, 20, "韩亮亮"));
			orderMapper.insertOrder(new Order(2, new Date(), "钉宫新路2", 10, 20, "盘龙"));
			orderMapper.insertOrder(new Order(3, new Date(), "钉宫新路3", 10, 20, "韩亮亮"));
			System.out.println("插入数据成功");
		} catch (Exception e) {
			System.out.println("插入数据异常！");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}

	@Test
	public void testDetete() {
		try {
			orderMapper.deleteById(1);
			System.out.println("删除数据成功");
			OrderExample example = new OrderExample();
			Criteria criteria = example.createCriteria();
			List<Integer> ids = new ArrayList<Integer>();
			ids.add(2);
			ids.add(3);
			criteria.andIdIn(ids);
			orderMapper.deleteByExample(example);
			System.out.println("删除数据成功");
		} catch (Exception e) {
			System.out.println("删除数据失败，原因：" + e.getMessage());
			e.printStackTrace();
		}
	}

	@Test
	public void testfind() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cld = Calendar.getInstance();
		cld.setTime(new Date());
		cld.add(Calendar.DAY_OF_MONTH, 1);
		Date d2 = cld.getTime();
		System.err.println(d2);
		// List<Order> orders = orderMapper.findByExample("韩亮亮", new Date(), d2);
		// if (orders != null && orders.size() > 0) {
		// for (Order order : orders) {
		// System.out.println(order.toString());
		// }
		// }
	}

}
