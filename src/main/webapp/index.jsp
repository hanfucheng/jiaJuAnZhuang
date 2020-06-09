<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
		http://localhost:3306/crud
 -->
 <!-- 
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap-datetimepicker.min.js"></script>
  -->

<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/moment.js/2.24.0/moment-with-locales.js"></script>
 <script src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap-select.js"></script>


</head>
<body>
<!-- 修改的模态框 -->
<div class="modal fade" id="orderUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">提货单<font color="red">修改</font></h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">提货日期<font color="red">(必填)</font></label>
		    <div class="col-sm-10">
		            <div class='input-group date'  >
		                <input type='text' class="form-control" id = "createdate_update_static"/>
		                <span class="input-group-addon">
		                    <span class="glyphicon glyphicon-calendar"></span>
		                </span>
		            </div>
		      <span class="help-block"></span>
		    </div>		    
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">提货地址</label>
		    <div class="col-sm-10">
		      <input type="text" name="address" class="form-control" id="address_update_input" placeholder="可为空">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">商家</label>
		    <div class="col-sm-10">
		      <input type="text" name="vendor" class="form-control" id="vendor_update_input" placeholder="可为空">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">过路费<font color="red">￥</font></label>
		    <div class="col-sm-10">
		      <input type="text" name="roadpay" class="form-control" id="roadpay_update_input" placeholder="0">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">代付费<font color="red">￥</font></label>
		    <div class="col-sm-10">
		      <input type="text" name="prepay" class="form-control" id="prepay_update_input" placeholder="0">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">货运费<font color="red">￥</font></label>
		    <div class="col-sm-10">
		      <input type="text" name="transpay" class="form-control" id="transpay_update_input" placeholder="0">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">提货人</label>
		    <div class="col-sm-4">
				<select  id = "creator_update">
					<option>韩亮亮</option>
					<option>盘龙</option>
				</select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="order_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>



<!-- 订单新增添加的模态框 -->
<div class="modal fade" id="orderAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">提货单<font color="red">新增</font></h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
        
		  <div class="form-group">
		    <label class="col-sm-2 control-label">提货日期<font color="red">(必填)</font></label>
		    <div class="col-sm-10">
		            <div class='input-group date'  >
		                <input type='text' class="form-control" id = "createdate_add"/>
		                <span class="input-group-addon">
		                    <span class="glyphicon glyphicon-calendar"></span>
		                </span>
		            </div>
		      <span class="help-block"></span>
		    </div>
		  </div>        
        
		  <div class="form-group">
		    <label class="col-sm-2 control-label">提货地址</label>
		    <div class="col-sm-10">
		      <input type="text" name="address" class="form-control" id="address_input" placeholder="可为空">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">商家</label>
		    <div class="col-sm-10">
		      <input type="text" name="vendor" class="form-control" id="vendor_input" placeholder="可为空">
		      <span class="help-block"></span>
		    </div>
		  </div>

		  <div class="form-group">
		    <label class="col-sm-2 control-label">过路费<font color="red">￥</font></label>
		    <div class="col-sm-10">
		      <input type="text" name="roadpay" class="form-control" id="roadpay_add_input" placeholder="0">
		      <span class="help-block"></span>		    
		    </div>
		  </div>

		  <div class="form-group">
		    <label class="col-sm-2 control-label">待付费<font color="red">￥</font></label>
		    <div class="col-sm-10">
		      <input type="text" name="prepay" class="form-control" id="prepay_add_input" placeholder="0">
		      <span class="help-block"></span>		    
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">货运费<font color="red">￥</font></label>
		    <div class="col-sm-10">
		      <input type="text" name="transpay" class="form-control" id="transpay_add_input" placeholder="0">
		      <span class="help-block"></span>		    
		    </div>
		  </div>
		  
		  
		   <div class="form-group">
		    <label class="col-sm-2 control-label">提货人</label>
		    <div class="col-sm-4">
				<select  id = "creator_add">
					<option>韩亮亮</option>
					<option>盘龙</option>
				</select>		    
				 <span class="help-block"></span>	
		    </div>
		     <span class="help-block"></span>	
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>



<!-- 搭建显示页面 -->
<div class="container">
	<!-- 标题 -->
	<div class="row" >
		<div class="col-md-12">
			<h1 align="center">家具安装韩师傅</h1>
		</div>
	</div>
	<!-- 按钮 -->
	<div class="row" style="border:2px solid red;">
	    <div class='col-sm-6' style="width:200px;">
	        <div class="form-group">
	            <label>起始日期：</label>
	            <!--指定 date标记-->
	            <div class='input-group date' >
	                <input type='text' class="form-control" id = "dateGt"/>
	                <span class="input-group-addon">
	                    <span class="glyphicon glyphicon-calendar"></span>
	                </span>
	            </div>
	        </div>
	    </div>
	    <div class='col-sm-6' style="width:200px;float:left">
	        <div class="form-group">
	            <label>终止日期：</label>
	            <!--指定 date标记-->
	            <div class='input-group date'>
	                <input type='text' class="form-control" id = "dateLt"/>
	                <span class="input-group-addon">
	                    <span class="glyphicon glyphicon-calendar"></span>
	                </span>
	            </div>
	        </div>
	    </div>
	    <div class='col-sm-6' style="width:200px;float:left">
	        <div class="form-group">
	        	<div><label>提货人：</label></div>
			    <div class="col-sm-4"  style="height:34px;float:left">
					<select  id = "creator_select" >
						<option></option>
						<option>韩亮亮</option>
						<option>盘龙</option>
					</select>
			    </div>			    
	        </div>
	    </div>
	    <div class='col-sm-6' style="width:200px;float:left">
	        <div class="form-group">
	        	<div><label>商家<font style="color: red;">(可以模糊查询)</font>：</label></div>
			    <div class="col-sm-4"  style="height:34px;float:left">
			    	<b><input type="text" class="form-control" id="vendor" style="color: red;width: 400px"></b>
			    </div>			    
	        </div>
	    </div>	    
	</div>
	<div>
			<button class="btn btn-warning" id="clear_btn">清空查询条件</button>
			<button class="btn btn-success" id="search_btn">查询提货单</button>
			<button class="btn btn-primary" id="add_btn">新增</button>
			<button class="btn btn-danger" id="delete_all_btn">批量删除</button>
			<button class="btn btn btn-info" id="sum_raodpay_all_btn">合计过路费</button>
			<button class="btn btn btn-info" id="sum_prepay_all_btn">合计代付费</button>
			<button class="btn btn btn-info" id="sum_transpay_all_btn">合计货运费</button>
			<button class="btn btn btn-success" id="sumAll_btn">合计总支出</button>		
	</div>

	<div id = "hidderOrShow" style="display: none;">
		<b><input type="text" class="form-control" id="resultMsg" style="color: red;"></b>
	</div>
	<!-- 显示表格数据 -->
	<div class="row" style="border:2px solid ;">
		<div class="col-md-12">
			<table class="table table-hover" id="orders_table">
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="check_all"/>
						</th>
						<th>序号</th>
						<th>提货日期</th>
						<th>提货地址</th>
						<th>商家</th>
						<th>过路费(元)</th>
						<th>代付款(元)</th>
						<th>货运费(元)</th>
						<th>提货人</th>
						<th>合计(元)</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>

	<!-- 显示分页信息 -->
	<div class="row" >
		<!--分页文字信息  -->
		<div>
			<div class="col-md-6" id="page_info_area" float="left;" ></div>
			<div class="col-md-6" id="page_info_area_number" float="right" ></div>
		</div>
		<!-- 分页条信息 -->
		<div class="col-md-6" id="page_nav_area">
			
		</div>
	</div>
</div>
	
	
	<script type="text/javascript">
		var totalRecord,currentPage;
		var dateGt = $("#dateGt").val();
		var dateLt = $("#dateLt").val();
		var vendor = $("#vendor").val();
		if(dateGt !="" && dateLt!="" && dateGt >= dateLt){
			alert("【起始日期】必须小于【终止日期】");
		}
        var creator = $("#creator_select").val();
		//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
		$(function(){
			//去首页
			to_pageWithQuery(1,creator,dateGt,dateLt,vendor);
		});
		
		function to_pageWithQuery(pn,creator,dateGt,dateLt,vendor){
			$.ajax({
				url:"${APP_PATH}/findByExample",
				url:"${APP_PATH}/findByExample",
				data:"pn="+pn+"&creator=" +creator+"&dateGt="+dateGt+"&dateLt="+dateLt+"&vendor="+vendor ,
				success:function(result){
					//console.log(result);
					//1、解析并显示员工数据
					build_orders_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);
				}
			});
		}

function build_orders_table(result){
	//清空table表格
	$("#orders_table tbody").empty();
	var orders = result.extend.pageInfo.list;
	$.each(orders,function(index,item){
			var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
			var id = $("<td></td>").append(item.id);
			var timsStamp = item.createdate;
			var createdate = "";
			if(timsStamp !=null || timsStamp !=""){
            let date = new Date(timsStamp);
            let year = date.getFullYear();
            let month = date.getMonth()+1;
            let day = date.getDate();
            month = month < 10 ? "0"+month:month;
            day = day < 10 ? "0"+day:day;
            var dateString = year+'-'+month+'-'+day;
			createdate = $("<td></td>").append(dateString); //提货日期
		}

	var address = $("<td></td>").append(item.address); //提货地址
	var vendor = $("<td></td>").append(item.vendor); //商家
	var roadpay = $("<td></td>").append(item.roadpay); //过路费
	var prepay = $("<td></td>").append(item.prepay); //代付费
	var transpay = $("<td></td>").append(item.transpay); //货运费
	var creator = $("<td></td>").append(item.creator);
	var personOneSum = $("<td></td>").append(item.roadpay+item.prepay+item.transpay); //个人单日合计
	var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
	//为编辑按钮添加一个自定义的属性，来表示当前员工id
	editBtn.attr("edit-id",item.id);
	var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
	//为删除按钮添加一个自定义的属性来表示当前删除的员工id
	delBtn.attr("del-id",item.id);
	var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
	//var delBtn = 
	//append方法执行完成以后还是返回原来的元素
	$("<tr></tr>").append(checkBoxTd)
		.append(id)
		.append(createdate)
		.append(address)
		.append(vendor)
		.append(roadpay)
		.append(prepay)
		.append(transpay)
		.append(creator)
		.append(personOneSum)
		.append(btnTd)
		.appendTo("#orders_table tbody");
	});
}
		
		
		
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前页有【"+result.extend.pageInfo.size+"】条数记录");
			//$("#page_info_area").append("当前是第【"+result.extend.pageInfo.pageNum+"】页,总共【"+
			//		result.extend.pageInfo.pages+"】页,当前页有【"+result.extend.pageInfo.size+"】条数记录");
			
			$("#page_info_area_number").empty();
			$("#page_info_area_number").append("查询结果共【"+
					result.extend.pageInfo.total+"】条记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//解析显示分页条，点击分页要能去下一页....
		function build_page_nav(result){
			var dateGt = $("#dateGt").val();
			var dateLt = $("#dateLt").val();
			var vendor = $("#vendor").val();
			if(dateGt !="" && dateLt!="" && dateGt >= dateLt){
				alert("【起始日期】必须小于【终止日期】");
				return;
			}
            var creator = $("#creator_select").val();
			
			//page_nav_area
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			//构建元素
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页的事件
				firstPageLi.click(function(){
					//to_pageWithQuery(1);
					to_pageWithQuery(1,creator,dateGt,dateLt,vendor);
				});
				prePageLi.click(function(){
					to_pageWithQuery(result.extend.pageInfo.pageNum -1,creator,dateGt,dateLt,vendor);
					//to_pageWithQuery();
				});
			}
			
			
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_pageWithQuery(result.extend.pageInfo.pageNum +1,creator,dateGt,dateLt,vendor);
				});
				lastPageLi.click(function(){
					to_pageWithQuery(result.extend.pageInfo.pages,creator,dateGt,dateLt,vendor);
				});
			}
			
			
			
			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			//1,2，3遍历给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_pageWithQuery(item,creator,dateGt,dateLt,vendor);
				});
				ul.append(numLi);
			});
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮弹出模态框。
		$("#add_btn").click(function(){
			//清除表单数据（表单完整重置（表单的数据，表单的样式））
			reset_form("#orderAddModal form");
			//s$("")[0].reset();
			//发送ajax请求，查出部门信息，显示在下拉列表中
			//弹出模态框
			$("#orderAddModal").modal({
				backdrop:"static"
			});
		});
		
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		
		
		//1、我们是按钮创建之前就绑定了click，所以绑定不上。
		//1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
		//jquery新版没有live，使用on进行替代
		$(document).on("click",".edit_btn",function(){
			var idOne = $(this).attr("edit-id");
			//2、查出员工信息，显示员工信息
			getOrder(idOne);
			
			//3、把员工的id传递给模态框的更新按钮
			$("#order_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#orderUpdateModal").modal({
				backdrop:"static"
			});
			
			//点击更新，更新员工信息
			$("#order_update_btn").click(function(){
				var id = $(this).attr("edit-id");
	            var createdate = $("#createdate_update_static").val();
	            var address = $("#address_update_input").val();
	            var vendor = $("#vendor_update_input").val();
	            var roadpay = $("#roadpay_update_input").val() ==""?0:$("#roadpay_update_input").val();
	            var prepay = $("#prepay_update_input").val()==""?0:$("#prepay_update_input").val();
	            var transpay = $("#transpay_update_input").val()==""?0:$("#transpay_update_input").val();
	            var creator = $("#creator_update").val();
		        $.ajax({
		            url:"${APP_PATH}/updateOrder",
		            type:"post",
		            //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
		            data:"id="+id+"&createdate="+createdate+"&address="+address+"&roadpay="+roadpay+"&prepay="+prepay+"&creator="+creator+"&vendor="+vendor+"&transpay="+transpay,    
		            dataType:"json",
		            success:function (result) {
		            	if(result.code == 100){
							//员工保存成功；
		            		//alert("修改成功");
							//1、关闭模态框
		            		$("#orderUpdateModal").modal('hide');
							//2、来到最后一页，显示刚才保存的数据
							//发送ajax请求显示最后一页数据即可
							//to_pageWithQuery(totalRecord);                		
							//发送ajax请求显示第一页数据即可
							to_pageWithQuery(1,"","","","");
		            	}
		            }
		        })
			});			
			
			
		});
		
		function getOrder(id){
			$.ajax({
				url:"${APP_PATH}/getOrderById/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var orderData = result.extend.order;
					 let date = new Date(orderData.createdate);
			            let year = date.getFullYear();
			            let month = date.getMonth()+1;
			            let day = date.getDate();
			            month = month < 10 ? "0"+month:month;
			            day = day < 10 ? "0"+day:day;
			            var dateString = year+'-'+month+'-'+day;
					$("#createdate_update_static").val(dateString);
					$("#address_update_input").val(orderData.address);
					$("#vendor_update_input").val(orderData.vendor);
					$("#roadpay_update_input").val([orderData.roadpay]);
					$("#prepay_update_input").val([orderData.prepay]);
					$("#transpay_update_input").val([orderData.transpay]);
					$("#orderUpdateModal select").val([orderData.creator]);
				}
			});
		}
		

		
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//1、弹出是否确认删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var id = $(this).parents("tr").find("td:eq(1)").text();
			var b = $(this).parents("tr").find("td:eq(2)").text();
			var c = $(this).parents("tr").find("td:eq(3)").text();
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			//alert($(this).parents("tr").find("td:eq(1)").text());
			if(confirm("确定要删除序号为【"+id+"】的提货单吗？")){
				//确认，发送ajax请求删除即可
				$.ajax({
					url:"${APP_PATH}/order/"+id,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_pageWithQuery(currentPage,"","","","");
					}
				});
			}
		});
		
		//完成全选/全不选功能
		$("#check_all").click(function(){
			//attr获取checked是undefined;
			//我们这些dom原生的属性；attr获取自定义属性的值；
			//prop修改和读取dom原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//check_item
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否5个
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，就批量删除
		$("#delete_all_btn").click(function(){
			//
			//var empNames = "";
			var del_idstr = "";
			var ids = "";
			$.each($(".check_item:checked"),function(){
				//this
				//empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				ids += $(this).parents("tr").find("td:eq(1)").text()+",";
			});
			//去除empNames多余的,
			ids = ids.substring(0, ids.length-1);
			//去除删除的id多余的-
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			if(del_idstr==""){
				alert("请先选中提货单");
				return;
			}
			
			if(confirm("确认删除【"+ids+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/order/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_pageWithQuery(currentPage,"","","","");
					}
				});
			}
		});
		

        function getSdfDate(time){
            let date = new Date(cTime);
            let year = date.getFullYear();
            let month = date.getMonth()+1;
            let day = date.getDate();
            month = month < 10 ? "0"+month:month;
            day = day < 10 ? "0"+day:day;
            d.date = year+'-'+month+'-'+day;
            console.log(d); // 2018-10-09
        }
        

// https://blog.csdn.net/qq_33368846/article/details/82223676
        $(function () {
            $('.date').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: moment.locale('zh-cn')
            });
        });
            
        $(function () {
            $('#datetimepicker2').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: moment.locale('zh-cn')
            });
        });
        
        $(function () {
            $('#datetimepicker3').datetimepicker({
                format: 'YYYY-MM-DD',
                locale: moment.locale('zh-cn')
            });
        });
        
        $("#emp_save_btn").click(function () {
            //获取值
            var createdate = $("#createdate_add").val();
            var address = $("#address_input").val();
            var vendor = $("#vendor_input").val();
            var roadpay = $("#roadpay_add_input").val() ==""?0:$("#roadpay_add_input").val();
            var prepay = $("#prepay_add_input").val()==""?0:$("#prepay_add_input").val();
            var transpay = $("#transpay_add_input").val()==""?0:$("#transpay_add_input").val();
            var creator = $("#creator_add").val();
            $.ajax({
                url:"${APP_PATH}/insertOrder",
                type:"post",
                //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                data:"createdate="+createdate+"&address="+address+"&roadpay="+roadpay+"&prepay="+prepay+"&creator="+creator+"&vendor="+vendor+"&transpay="+transpay,    
                dataType:"json",
                success:function (result) {
                	if(result.code == 100){
						//员工保存成功；
                		alert("新增成功");
						//1、关闭模态框
                		$("#orderAddModal").modal('hide');
						//2、来到最后一页，显示刚才保存的数据
						//发送ajax请求显示最后一页数据即可
						//to_pageWithQuery(totalRecord);                		
						//发送ajax请求显示第一页数据即可
						to_pageWithQuery(1,"","","","");
                	}
                }
            })
        })        
        
		function show_validate_msg(ele,status,msg){
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
        
        
		$("#search_btn").click(function(){
			var dateGt = $("#dateGt").val();
			var dateLt = $("#dateLt").val();
			var vendor = $("#vendor").val();
			if(dateGt !="" && dateLt!="" && dateGt >= dateLt){
				alert("【起始日期】必须小于【终止日期】");
				return;
			}
            var creator = $("#creator_select").val();
			var totalRecord,currentPage;
			//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
			$(function(){
				//去首页
				document.getElementById("hidderOrShow").style.display="none";//隐藏
				to_pageWithQuery(1,creator,dateGt,dateLt,vendor);
			});
		 })
		 
		$("#clear_btn").click(function(){
			$("#dateGt").val("");
			$("#dateLt").val("");
			$("#vendor").val("");
			$("#creator_select").val("");
			//1、页面加载完成以后，直接去发送ajax请求,要到分页数据
			$(function(){
				//去首页
				//document.getElementById("hidderOrShow").style.display="none";//隐藏
				//to_pageWithQuery(1,creator,dateGt,dateLt,vendor);
			});
		 }) 	
		
		function to_pageWithQuery(pn,creator,dateGt,dateLt,vendor){
			$.ajax({
				url:"${APP_PATH}/findByExample",
				data:"pn="+pn+"&creator=" +creator+"&dateGt="+dateGt+"&dateLt="+dateLt+"&vendor="+vendor ,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1、解析并显示员工数据
					build_orders_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);
				}
			});
		} 
		
		$("#sum_raodpay_all_btn").click(function(){
			var dateGt = $("#dateGt").val();
			var dateLt = $("#dateLt").val();
			var vendor = $("#vendor").val();
			if(dateGt !="" && dateLt!="" && dateGt >= dateLt){
				alert("【起始日期】必须小于【终止日期】");
				return;
			}
			
            var creator = $("#creator_select").val();
			$.ajax({
				url:"${APP_PATH}/sumPays",
				data:"creator=" +creator+"&dateGt="+dateGt+"&dateLt="+dateLt+"&type=1"+"&vendor="+vendor ,
				type:"GET",
				success:function(result){
					document.getElementById("hidderOrShow").style.display="";//显示
					$("#resultMsg").val(result.extend.resultMsg);
				}
			});
		 }) 
		 
		$("#sum_prepay_all_btn").click(function(){
			var dateGt = $("#dateGt").val();
			var dateLt = $("#dateLt").val();
			var vendor = $("#vendor").val();
			if(dateGt !="" && dateLt!="" && dateGt >= dateLt){
				alert("【起始日期】必须小于【终止日期】");
				return;
			}
			
            var creator = $("#creator_select").val();
			$.ajax({
				url:"${APP_PATH}/sumPays",
				data:"creator=" +creator+"&dateGt="+dateGt+"&dateLt="+dateLt+"&type=2"+"&vendor="+vendor ,
				type:"GET",
				success:function(result){
					document.getElementById("hidderOrShow").style.display="";//显示
					$("#resultMsg").val(result.extend.resultMsg);
				}
			});
		 }) 
		 
		$("#sumAll_btn").click(function(){
			var dateGt = $("#dateGt").val();
			var dateLt = $("#dateLt").val();
			var vendor = $("#vendor").val();
			if(dateGt !="" && dateLt!="" && dateGt >= dateLt){
				alert("【起始日期】必须小于【终止日期】");
				return;
			}
			
            var creator = $("#creator_select").val();
			$.ajax({
				url:"${APP_PATH}/sumPays",
				data:"creator=" +creator+"&dateGt="+dateGt+"&dateLt="+dateLt+"&type=3"+"&vendor="+vendor ,
				type:"GET",
				success:function(result){
					document.getElementById("hidderOrShow").style.display="";//显示
					$("#resultMsg").val(result.extend.resultMsg);
				}
			});
		 }) 
		 
		$("#sum_transpay_all_btn").click(function(){
			var dateGt = $("#dateGt").val();
			var dateLt = $("#dateLt").val();
			var vendor = $("#vendor").val();
			if(dateGt !="" && dateLt!="" && dateGt >= dateLt){
				alert("【起始日期】必须小于【终止日期】");
				return;
			}
			
            var creator = $("#creator_select").val();
			$.ajax({
				url:"${APP_PATH}/sumPays",
				data:"creator=" +creator+"&dateGt="+dateGt+"&dateLt="+dateLt+"&type=4"+"&vendor="+vendor ,
				type:"GET",
				success:function(result){
					document.getElementById("hidderOrShow").style.display="";//显示
					$("#resultMsg").val(result.extend.resultMsg);
				}
			});
		 }) 		 
		
		function to_pageWithQuery(pn,creator,dateGt,dateLt,vendor){
			$.ajax({
				url:"${APP_PATH}/findByExample",
				data:"pn="+pn+"&creator=" +creator+"&dateGt="+dateGt+"&dateLt="+dateLt+"&vendor="+vendor ,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1、解析并显示员工数据
					build_orders_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条数据
					build_page_nav(result);
				}
			});
		}      		
        
	</script>
</body>
</html>