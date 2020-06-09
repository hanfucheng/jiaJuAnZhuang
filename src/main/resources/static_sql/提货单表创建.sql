DROP DATABASE IF	EXISTS jiaJuAnZhuang;
-- 创建数据库的时候，直接指定数据库的du字符集，之后再该数据zhi库中创建表的时候就不dao用再指定了，所有创建的表都是跟数据库字符集一样的。
-- 这样在数据库 jiaJuAnZhuang 中在创建表的时候，只要不指定字符集，默认都是utf8
CREATE DATABASE jiaJuAnZhuang default character set utf8;
USE jiaJuAnZhuang;
DROP TABLE
IF
	EXISTS c_order;
CREATE TABLE c_order (
 -- id INT ( 8 ) PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '订单id',
	id INT ( 8 ) PRIMARY KEY NOT NULL  COMMENT '订单id',
	createdate date COMMENT '提货日期',
	address VARCHAR ( 255 ) COMMENT '提货地址',
	vendor VARCHAR ( 1000 ) COMMENT '商家',
	roadpay INT COMMENT '过路费',
	prepay INT COMMENT '代付费',
	transpay INT COMMENT '货运费',
	creator VARCHAR ( 255 ) COMMENT '提货人' 
) COMMENT = '提货单表';


set character_set_client=utf8;
set character_set_server=utf8;
set character_set_database=utf8;