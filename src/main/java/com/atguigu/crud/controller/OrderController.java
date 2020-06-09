package com.atguigu.crud.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.bean.Order;
import com.atguigu.crud.service.OrderService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理和部门有关的请求
 * @author lfy
 *
 */
@Controller
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	

	/**
	 * 查询所有订单
	 */
	@RequestMapping("/findAll")
	@ResponseBody
	public Msg findAllWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 这不是一个分页查询
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 3);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Order> orders = orderService.findAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo<Order> page = new PageInfo<Order>(orders, orders == null ? 0 : orders.size());

		// PageInfo<Order> page = new PageInfo<Order>(orders, 10);
		return Msg.success().add("pageInfo", page);
	}

	@RequestMapping(value = "/insertOrder", method = RequestMethod.POST)
	@ResponseBody
	public Msg insertOrder(@RequestParam String createdate, @RequestParam String address, @RequestParam int roadpay, @RequestParam int prepay, @RequestParam String creator, @RequestParam int transpay,
			@RequestParam String vendor) {
		Order order = new Order();
		int maxId = orderService.findMaxId();
		order.setId(maxId);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date createDate = null;
		try {
			createDate = sdf.parse(createdate);
		} catch (ParseException e) {
			createDate = new Date();
			e.printStackTrace();
		}
		order.setCreatedate(createDate);
		order.setAddress(address);
		order.setRoadpay(roadpay);
		order.setPrepay(prepay);
		order.setCreator(creator);
		order.setTranspay(transpay);
		order.setVendor(vendor);
		orderService.insertOrder(order);
		return Msg.success();
	}

	@RequestMapping(value = "/updateOrder", method = RequestMethod.POST)
	@ResponseBody
	public Msg updateOrder(@RequestParam int id, @RequestParam String createdate, @RequestParam String address, @RequestParam int roadpay, @RequestParam int prepay, @RequestParam String creator,
			@RequestParam int transpay, @RequestParam String vendor) {
		Order order = orderService.getOrderById(id);
		if (createdate != null && !"".equals(createdate)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				order.setCreatedate(sdf.parse(createdate));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		order.setAddress(address);
		order.setRoadpay(roadpay);
		order.setPrepay(prepay);
		order.setCreator(creator);
		order.setTranspay(transpay);
		order.setVendor(vendor);
		orderService.updateOrder(order);
		return Msg.success();
	}

	@ResponseBody
	@RequestMapping(value = "/order/{ids}", method = RequestMethod.DELETE)
	public Msg deleteOrder(@PathVariable("ids") String ids) {
		// 批量删除
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			// 组装id的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			orderService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			orderService.deleteById(id);
		}
		return Msg.success();
	}

	/**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Employee 
	 * [empId=1014, empName=null, gender=null, email=null, dId=null]
	 * 
	 * 问题：
	 * 请求体中有数据；
	 * 但是Employee对象封装不上；
	 * update tbl_emp  where emp_id = 1014;
	 * 
	 * 原因：
	 * Tomcat：
	 * 		1、将请求体中的数据，封装一个map。
	 * 		2、request.getParameter("empName")就会从这个map中取值。
	 * 		3、SpringMVC封装POJO对象的时候。
	 * 				会把POJO中每个属性的值，request.getParamter("email");
	 * AJAX发送PUT请求引发的血案：
	 * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
	 * org.apache.catalina.connector.Request--parseParameters() (3111);
	 * 
	 * protected String parseBodyMethods = "POST";
	 * if( !getConnector().isParseBodyMethod(getMethod()) ) {
	            success = true;
	            return;
	        }
	 * 
	 * 
	 * 解决方案；
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、他的作用；将请求体中的数据解析包装成一个map。
	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
	 * 员工更新方法
	 * @param order
	 * @return
	 */
	// @ResponseBody
	// @RequestMapping(value = "/updateOrder/{id}", method = RequestMethod.PUT)
	// public Msg updateOrder(Order order, HttpServletRequest request) {
	// orderService.updateOrder(order);
	// return Msg.success();
	// }

	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/getOrderById/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getOrderById(@PathVariable("id") Integer id) {

		Order order = orderService.getOrderById(id);
		return Msg.success().add("order", order);
	}

	@RequestMapping("/findByExample")
	@ResponseBody
	public Msg findByExample(@RequestParam(value = "pn", defaultValue = "1") Integer pn, @RequestParam("creator") String creator, @RequestParam("dateGt") String dateGt,
			@RequestParam("dateLt") String dateLt, @RequestParam("vendor") String vendor) {
		// 这不是一个分页查询
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 10);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date createDateGt = null;
		Date createDateLt = null;
			try {
				createDateGt = sdf.parse(dateGt);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		if (dateLt != null && !"".equals(dateLt)) {
			try {
				createDateLt = sdf.parse(dateLt);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		List<Order> orders = orderService.findByExample(creator, createDateGt, createDateLt, vendor);
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo<Order> page = new PageInfo<Order>(orders, orders == null ? 0 : orders.size());
		return Msg.success().add("pageInfo", page);
	}

	@RequestMapping("/sumPays")
	@ResponseBody
	public Msg sumPays(@RequestParam("creator") String creator, @RequestParam("dateGt") String dateGt, @RequestParam("dateLt") String dateLt, @RequestParam("type") int type,
			@RequestParam("vendor") String vendor
			) {
		String payType = "";
		if (type == 1) {
			payType = "过路费";
		} else if (type == 2) {
			payType = "代付费";
		} else if (type == 3) {
			payType = "总支出";
		}else if (type == 4) {
			payType = "货运费";
		}
		// 这不是一个分页查询
		// 引入PageHelper分页插件
		// 在查询之前只需要调用，传入页码，以及每页的大小
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date createDateGt = null;
		Date createDateLt = null;
		try {
			createDateGt = sdf.parse(dateGt);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if (dateLt != null && !"".equals(dateLt)) {
			try {
				createDateLt = sdf.parse(dateLt);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		StringBuilder sb = new StringBuilder();
		if (creator != null && !creator.equals("")) {
			sb.append("【" + creator + "】,");
		}else{
			sb.append("【韩亮亮,盘龙】");
		}
		if (createDateGt != null && createDateLt != null) {
			sb.append("在【" + dateGt + "】-【" + dateLt + "】内,");
		} else if (createDateGt != null && createDateLt == null) {
			sb.append("在【" + dateGt + "】当天,");
		}
		int pays = 0;
		List<Order> orders = orderService.findByExample(creator, createDateGt, createDateLt, vendor);
		if (orders == null || orders.size() == 0) {
			new HashMap<String, Object>();
			return Msg.fail().add("resultMsg", "查询到的提货单为空！");
		} else {
			for (Order order : orders) {
				if (type == 1) {
					pays += order.getRoadpay();
				} else if (type == 2) {
					pays += order.getPrepay();
				} else if (type == 3) {
					pays += (order.getRoadpay() + order.getPrepay() + order.getTranspay());
				} else if (type == 4) {
					pays += order.getTranspay();
				}
			}
			sb.append("【" + payType).append("】共计【" + pays + "】元");
		}
		return Msg.success().add("resultMsg", sb.toString());
	}



}
