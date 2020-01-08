/*
SQLyog Enterprise v12.4.1 (64 bit)
MySQL - 5.5.28 : Database - origin_master
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`origin_master` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `origin_master`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_account` varchar(50) NOT NULL DEFAULT '' COMMENT '管理员帐号',
  `admin_password` char(32) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `admin_fullname` varchar(255) DEFAULT NULL COMMENT '管理员姓名',
  `admin_head` varchar(255) DEFAULT NULL COMMENT '管理员头像',
  `admin_phone` char(11) DEFAULT NULL COMMENT '管理员手机号码',
  `one_region_id` int(11) DEFAULT NULL COMMENT '管辖一级区域id',
  `two_region_ids` varchar(255) DEFAULT NULL COMMENT '管辖二级区域id集合   如：1,2,3...',
  `status` tinyint(1) DEFAULT '2' COMMENT '状态   1可用   2禁用  默认2',
  `admin_ticket` char(32) DEFAULT NULL COMMENT '管理员入场券（用于抢登）',
  `last_login_time` int(11) DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(32) DEFAULT NULL COMMENT '最后登录ip',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `admin_account` (`admin_account`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='管理员表';

/*Data for the table `admin` */

insert  into `admin`(`id`,`admin_account`,`admin_password`,`admin_fullname`,`admin_head`,`admin_phone`,`one_region_id`,`two_region_ids`,`status`,`admin_ticket`,`last_login_time`,`last_login_ip`,`create_time`,`update_time`) values 
(11,'kwd','21232f297a57a5a743894a0e4a801fc3',NULL,NULL,NULL,NULL,NULL,1,'lU3J2O4Ydy7nSzBSIdprHXEq1QpO1fEH',1515939269,'127.0.0.1',NULL,NULL);

/*Table structure for table `admin_role` */

DROP TABLE IF EXISTS `admin_role`;

CREATE TABLE `admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '管理员id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

/*Data for the table `admin_role` */

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(30) DEFAULT NULL COMMENT '角色名称',
  `rule_ids` varchar(2000) DEFAULT NULL COMMENT '角色权限集合   如1,2,3...',
  `status` tinyint(1) DEFAULT '2' COMMENT '角色状态  1正常    2禁用  默认2',
  `remark` varchar(255) DEFAULT NULL COMMENT '角色注释',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `role` */

insert  into `role`(`id`,`role_name`,`rule_ids`,`status`,`remark`,`create_time`,`update_time`) values 
(1,'普通帐号','25,26,33,50,51',1,'部分权限',1491616063,1494317574);

/*Table structure for table `rule` */

DROP TABLE IF EXISTS `rule`;

CREATE TABLE `rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_name` varchar(30) DEFAULT NULL COMMENT '权限名称',
  `rule` varchar(255) DEFAULT NULL COMMENT '权限规则',
  `is_menu` tinyint(1) DEFAULT '2' COMMENT '是否菜单  1是   2否    默认2',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级ID    0一级    非0子级',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) DEFAULT '2' COMMENT '状态   1可用    2禁用  默认2',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `rule` (`rule`) USING BTREE,
  KEY `is_menu` (`is_menu`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='权限规则表';

/*Data for the table `rule` */

insert  into `rule`(`id`,`rule_name`,`rule`,`is_menu`,`parent_id`,`icon`,`sort`,`status`,`create_time`,`update_time`) values 
(1,'开发者模块','null',1,0,'fa fa-cogs',2,1,1491274084,NULL),
(15,'添加权限','system/addRule',2,29,'',2,1,1491289892,1491316960),
(19,'删除权限','system/deleteRule',2,29,'',4,1,1491311270,1491317010),
(20,'权限排序','system/sortRule',2,29,'',5,1,1491311307,1491317016),
(21,'修改权限','system/editRule',2,29,'',3,1,1491311794,1491617447),
(25,'用户模块','null',1,0,'fa fa-user-circle',1,1,1491370403,NULL),
(26,'管理员管理','system/adminList',1,25,'',1,1,1491370469,1491371578),
(27,'角色管理','system/roleList',1,1,'',2,1,1491370500,1491749059),
(28,'添加角色','system/addRole',2,27,'',2,1,1491611720,NULL),
(29,'权限管理','system/ruleList',1,1,'',1,1,1491612179,1491619969),
(31,'修改角色','system/editRole',2,27,'',3,1,1491617401,NULL),
(32,'删除角色','system/deleteRole',2,27,'',4,1,1491617423,NULL),
(33,'添加管理员','system/addAdmin',2,26,'',2,1,1491622839,NULL),
(34,'修改管理员','system/editAdmin',2,26,'',3,1,1491622873,NULL),
(35,'删除管理员','system/deleteAdmin',2,26,'',5,1,1491622895,NULL),
(50,'网站设置','system/setting',1,1,'',4,1,1492156891,1492158539),
(51,'修改网站设置','system/editSetting',2,50,'',0,1,1492156977,1492158549),
(57,'自定义菜单','system/menuList',1,63,'',3,1,1497863852,1498039690),
(58,'添加微信菜单','system/addMenu',2,57,'',1,1,1497922732,1497937727),
(59,'修改微信菜单','system/editMenu',2,57,'',2,1,1497937627,1497937742),
(60,'微信菜单排序','system/sortMenu',2,57,'',3,1,1497937659,1497937712),
(61,'删除微信菜单','system/deleteMenu',2,57,'',4,1,1497937697,NULL),
(62,'推送微信菜单','system/pushWxMenu',2,57,'',5,1,1497938063,1497938076),
(63,'微信模块','null',1,0,'fa fa-wechat',3,1,1498009097,NULL),
(64,'关注公众号','system/welcomeSetting',1,63,'',1,1,1498039646,1498119224);

/*Table structure for table `setting` */

DROP TABLE IF EXISTS `setting`;

CREATE TABLE `setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `website_title` varchar(255) DEFAULT NULL COMMENT '网站标题',
  `copyright` varchar(255) DEFAULT NULL COMMENT '网站版权',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `setting` */

insert  into `setting`(`id`,`website_title`,`copyright`) values 
(1,'LAYUI后台管理','Copyright&amp;nbsp;&amp;nbsp;©&amp;nbsp;&amp;nbsp;2018&amp;nbsp;&amp;nbsp;广州市食议兽信息科技有限公司&amp;nbsp;&amp;nbsp;技术支持：凌晨四点团队');

/*Table structure for table `wx_menu` */

DROP TABLE IF EXISTS `wx_menu`;

CREATE TABLE `wx_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '父级id',
  `button_level` varchar(30) DEFAULT NULL COMMENT '菜单类型   button 一级菜单（最多3个）, sub_button 二级菜单（最多5个）',
  `type` varchar(255) DEFAULT NULL COMMENT '动作类型，view，click，miniprogram',
  `wx_name` varchar(60) DEFAULT NULL COMMENT '菜单标题',
  `key` varchar(128) DEFAULT NULL COMMENT '菜单KEY值，用于消息接口推送',
  `url` varchar(1024) DEFAULT NULL COMMENT 'view、miniprogram类型必须',
  `res_type` varchar(30) DEFAULT NULL COMMENT '自动回复类型   news图文   image图片',
  `media_id` varchar(255) DEFAULT NULL COMMENT '回复内容',
  `imgurl` varchar(255) DEFAULT NULL COMMENT '图片url   响应图片素材的图片',
  `content` varchar(500) DEFAULT NULL COMMENT '回复文本内容',
  `appid` varchar(255) DEFAULT NULL COMMENT 'appid  miniprogram类型必须',
  `pagepath` varchar(255) DEFAULT NULL COMMENT 'pagepath miniprogram类型必须',
  `sort` tinyint(3) DEFAULT NULL COMMENT '排序',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  UNIQUE KEY `id` (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `wx_menu` */

insert  into `wx_menu`(`id`,`parent_id`,`button_level`,`type`,`wx_name`,`key`,`url`,`res_type`,`media_id`,`imgurl`,`content`,`appid`,`pagepath`,`sort`,`create_time`,`update_time`) values 
(11,0,'button','','%E4%B8%AA%E4%BA%BA%E4%B8%AD%E5%BF%83','','','','','',NULL,NULL,NULL,0,1497939480,NULL),
(12,0,'button','','%E5%85%B3%E4%BA%8E%E6%88%91%E4%BB%AC','','','','','',NULL,NULL,NULL,1,1497939569,NULL),
(13,12,'sub_button','click','%E8%81%94%E7%B3%BB%E6%88%91%E4%BB%AC','contact us',NULL,'news','xW9INc8YaFaHo8XJYMxPeiJ210lZ4pPVoIwuCa6yBq8','',NULL,NULL,NULL,1,1497939618,1497949468),
(24,11,'sub_button','click','%E6%88%91%E7%9A%84%E4%BF%A1%E6%81%AF','hehe','http://www.baidu.com','image','xW9INc8YaFaHo8XJYMxPeqqZ8bL8W25xEhizewJM6m0','http://mmbiz.qpic.cn/mmbiz_png/pCErWynFe5btIibHz55IaSekhYP4g7mcqZc8AQ0sia4JXOeandnwicJM0ibIm2QmuaiaoPE6SkKxMkSMxNmTYAK0Nzg/0?wx_fmt=png',NULL,NULL,NULL,3,1497949986,1498118869),
(26,11,'sub_button','view','%E6%88%91%E6%98%AF%E9%98%BF%E4%BC%9F',NULL,'http://www.baidu.com',NULL,NULL,NULL,NULL,NULL,NULL,2,1497953377,NULL),
(28,0,'button','click','%E5%85%B3%E4%BA%8E%E6%88%91%E4%BB%AC','nihao',NULL,'text',NULL,'','你好00',NULL,NULL,3,1510478048,1510478698);

/*Table structure for table `wx_welcome` */

DROP TABLE IF EXISTS `wx_welcome`;

CREATE TABLE `wx_welcome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `res_type` varchar(255) DEFAULT NULL COMMENT '关注回复内容类型   text   news   image',
  `content` varchar(1000) DEFAULT NULL COMMENT '回复文本内容',
  `media_id` varchar(255) DEFAULT NULL COMMENT '回复素材id',
  `imgurl` varchar(255) DEFAULT NULL COMMENT '回复图片的url',
  `status` tinyint(1) DEFAULT '2' COMMENT '状态    1启用   2禁用   默认禁用',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `wx_welcome` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
