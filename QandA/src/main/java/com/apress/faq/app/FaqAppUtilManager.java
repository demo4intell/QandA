package com.apress.faq.app;

import java.util.ArrayList;

import com.apress.faq.common.User;
import com.apress.faq.util.AppUtilManager;
import com.apress.faq.util.PasswordUtil;



public class FaqAppUtilManager extends AppUtilManager {
	
	private FaqUser adminUser;
	private ArrayList<FaqUser> users = new ArrayList<FaqUser>();
	private ArrayList<FaqCategory> categories = new ArrayList<FaqCategory>();
	
	private FaqAppUtilManager() {
		super();
	}
	
	public static FaqAppUtilManager getCategoriesSingleton() {
		if( singleton == null ) {
			singleton = new FaqAppUtilManager();
			singleton.initApp();
		}
		return (FaqAppUtilManager) singleton;
	}
	
	public void initApp() {
		super.initApp();
		modifyUser();
		initCategories();
	}
	
	public FaqUser getAdminUser() {
		return adminUser;
	}
	
	private void modifyUser() {
		this.adminUser = new FaqUser();
		User oldUser = super.getAdminUser();
		this.adminUser.setFirstName(oldUser.getFirstName());
		this.adminUser.setSurname(oldUser.getSurname());
		this.adminUser.setLoginName(oldUser.getLoginName());
		this.adminUser.setAge(oldUser.getAge());
		this.adminUser.setTopics(new String[0]);
		this.adminUser.setPassword(PasswordUtil.digest("password"));
		this.users.add(adminUser);
	}
	
	private FaqCategory createCategory( String catName ) {
		FaqCategory category = new FaqCategory( );
		category.setName( catName );
		category.postCreate( adminUser );
		return category;
	}
	
	public void initCategories() {
		FaqCategory cat = createCategory( "Dates and Times" );
		//addCategory( cat );
		cat = createCategory( "Strings and StringBuffers" ); 
		//addCategory( cat );
		cat = createCategory( "Threading" ); 
		//addCategory(cat);
	}
	
	public void addCategory( FaqCategory cat ) {
		this.categories.add( cat );
	}
	
	public void removeCategory( FaqCategory cat ) {
		this.categories.remove(cat);
	}
	
	public void addUser( FaqUser user ) {
		this.users.add(user);
	}
	
	public void removeUser( FaqUser user ) {
		this.users.remove( user );
	}
	
	public ArrayList<FaqUser> getUsers() {
		return this.users;
	}
	
	public ArrayList<FaqCategory> getCategories() {
		return this.categories;
	}
	
	public static String getPrefix( Class exClass ) {
		String className = exClass.getName();
		String prefix = "";
		String[] parts = className.split( "\\." );
		for( int i = 0; i < parts.length - 1; i++ ) {
			prefix += parts[i].charAt(0);
		}
		String lastPart = parts[ parts.length - 1 ];
		for( int i = 0; i < lastPart.length(); i++ ) {
			if( Character.isUpperCase( lastPart.charAt(i) ) ) {
				prefix += Character.toString( lastPart.charAt(i) ).toLowerCase();
			}
		}
		return prefix;
	}
	
	public static String getClass( String prefix ) {
		if( prefix.indexOf("-") != -1 ) {
			prefix = prefix.substring( 0, prefix.indexOf( "-" ) );
		}
		switch(prefix) {
			case "cafafu":
				return "com.apress.faq.app.FaqUser";
			case "cafafc":
				return "com.apress.faq.app.FaqCategory";
			case "cafafq":
				return "com.apress.faq.app.FaqQuestion";
			case "cafafa":
				return "com.apress.faq.app.FaqAnswer";
			case "cafafli":
				return "com.apress.faq.app.FaqLoginInfo";
			default:
				return "";
		}		
	}
	
	public FaqCategory getCategoryObject( String cid ) {
		for( FaqCategory cat : this.categories ) {
			if( cat.getUid().equals(cid) ) 
				return cat;
		}
		return null;
	}
	
	public FaqCategory getCategoryByName( String name ) {
		for( FaqCategory cat : this.categories ) {
			if( cat.getName().equals(name) ) 
				return cat;
		}
		return null;
	}
	
	public FaqUser getUserObject( String uid ) {
		for( FaqUser u : this.users ) {
			if( u.getUid().equals(uid) )
				return u;
		}
		return null;
	}
	
	public FaqUser getUserByLogin( String loginName ) {
		System.out.println(">>loginName "+loginName );
		for( FaqUser u : this.users ) {
			if( u.getLoginName().equals(loginName) )
				return u;
		}
		return null;
	}

}
