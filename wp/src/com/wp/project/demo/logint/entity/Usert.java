package com.wp.project.demo.logint.entity;
/**
 * @ClassName: User_t
 * @author: DaiWeikun
 * @Description:
 * @date:  2015年9月25日 下午5:35:38
 */
public class Usert {
	private int id ;                        //主键id
	private String user_name;               //登录的用户名
	private String password;                // 登录密码
	private int age;                        //年龄
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	
}
