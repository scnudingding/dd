<?php
use think\Route;



/****************************index模块***********************************/
Route::get('/', 'index/index/index');//首页


/****************************system模块**********************************/
//Login控制器
Route::group(['prefix' => 'system/login/'], function () {
	Route::any('system/login', 'login');//登录页面
	Route::any('system/logout', 'logout');//退出登录
});

//Admin控制器
Route::group(['prefix' => 'system/admin/'], function () {
	Route::get('system/adminList', 'adminList');//管理员列表
	Route::any('system/addAdmin', 'addAdmin');//添加管理员
	Route::any('system/editAdmin', 'editAdmin');//修改管理员
	Route::get('system/deleteAdmin', 'deleteAdmin');//删除管理员
	Route::post('system/uploadAdminHead', 'uploadAdminHead');//上传管理员头像
});

//Rule控制器
Route::group(['prefix' => 'system/rule/'], function () {
	Route::get('system/ruleList', 'ruleList');//权限列表
	Route::any('system/addRule', 'addRule');//添加权限
	Route::any('system/editRule', 'editRule');//修改权限
	Route::get('system/sortRule', 'sortRule');//权限排序
	Route::get('system/deleteRule', 'deleteRule');//删除权限
});

//Role控制器
Route::group(['prefix' => 'system/role/'], function () {
	Route::get('system/roleList', 'roleList');//角色列表
	Route::any('system/addRole', 'addRole');//添加角色
	Route::any('system/editRole', 'editRole');//修改角色
	Route::get('system/deleteRole', 'deleteRole');//删除角色
});

//Setting控制器
Route::group(['prefix' => 'system/setting/'], function () {
	Route::get('system/setting', 'setting');//网站设置页面
	Route::post('system/editSetting', 'editSetting');//编辑网站设置
});



Route::miss('system/error/notFound','GET');//404未找到页面