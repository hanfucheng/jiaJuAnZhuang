package com.atguigu.crud.bean;

import java.util.Date;

public class Order {
    private Integer id;

    private Date createdate;
	private Date dateGt;
	private Date dateLt;

    private String address;

	private Integer roadpay; // 过路费

	private Integer prepay; // 待付款

	private Integer transpay; // 货运费

    private String creator;
	private String vendor;// 商家

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Date createdate) {
        this.createdate = createdate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public Integer getRoadpay() {
        return roadpay;
    }

    public void setRoadpay(Integer roadpay) {
        this.roadpay = roadpay;
    }

    public Integer getPrepay() {
        return prepay;
    }

    public void setPrepay(Integer prepay) {
        this.prepay = prepay;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

	public Order(Integer id, Date createdate, String address, Integer roadpay, Integer prepay, String creator) {
		super();
		this.id = id;
		this.createdate = createdate;
		this.address = address;
		this.roadpay = roadpay;
		this.prepay = prepay;
		this.creator = creator;
	}

	public Order() {
		super();
	}

	@Override
	public String toString() {
		return "Order [id=" + id + ", createdate=" + createdate + ", address=" + address + ", roadpay=" + roadpay + ", prepay=" + prepay + ", creator=" + creator + "]";
	}

	public Date getDateGt() {
		return dateGt;
	}

	public void setDateGt(Date dateGt) {
		this.dateGt = dateGt;
	}

	public Date getDateLt() {
		return dateLt;
	}

	public void setDateLt(Date dateLt) {
		this.dateLt = dateLt;
	}

	public Integer getTranspay() {
		return transpay;
	}

	public void setTranspay(Integer transpay) {
		this.transpay = transpay;
	}

	public String getVendor() {
		return vendor;
	}

	public void setVendor(String vendor) {
		this.vendor = vendor;
	}

}