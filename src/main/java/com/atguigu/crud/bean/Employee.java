package com.atguigu.crud.bean;

import java.util.Date;

public class Employee {
    private Integer empId;

	// @Pattern(regexp="(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})"
	// ,message="用户名必须是2-5位中文或者6-16位英文和数字的组合")
    private String empName;
	private Date createdate;

	private double roadpay;
	private double prepay;

	// //@Email
	// @Pattern(regexp="^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
	// message="邮箱格式不正确")
	// private String email;

    private Integer dId;
    
    //希望查询员工的同时部门信息也是查询好的
    private Department department;
    

	public Employee(Integer empId, String empName, Date createdate, double roadpay, double prepay, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.createdate = createdate;
		this.roadpay = roadpay;
		this.prepay = prepay;
		this.dId = dId;
	}

	public Date getCreatedate() {
		return createdate;
	}

	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}

	public double getRoadpay() {
		return roadpay;
	}

	public void setRoadpay(double roadpay) {
		this.roadpay = roadpay;
	}

	public double getPrepay() {
		return prepay;
	}

	public void setPrepay(double prepay) {
		this.prepay = prepay;
	}


	public Employee() {
		super();
	}



	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }



    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}