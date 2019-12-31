package com.apress.faq.util;

import java.util.ArrayList;

import com.apress.faq.common.User;

public class AppUtilManager {
	
	protected static AppUtilManager singleton = null;
	private User adminUser;
	
	protected AppUtilManager() {
			
	}
	
	public User getAdminUser() {
		return this.adminUser;
	}
	
	public static AppUtilManager getCategoriesSingleton() {
		if( singleton == null ) {
			singleton = new AppUtilManager();
		}
		return singleton;
	}
	
	public void initApp() {
		this.adminUser = new User();
		adminUser.setFirstName("Admin");
		adminUser.setSurname("Administrator");
		adminUser.setLoginName("admin");
		adminUser.setAge(32);
		adminUser.setPassword( "password" );
	}
	
	public User login( String userName, String password ) {
		if( userName.equals( adminUser.getLoginName() ) ) {
			if( PasswordUtil.digest(password).equals( adminUser.getPassword() ) ) {
				return adminUser;
			}
		}
		return null;			
	}

}
