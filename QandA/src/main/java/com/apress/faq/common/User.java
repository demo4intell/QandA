package com.apress.faq.common;

import java.time.LocalDateTime;
import java.util.ArrayList;

import com.apress.faq.app.FaqAppUtilManager;
import com.apress.faq.util.*;


public class User implements MetaInterface {
	
	protected String uid;	
	private String firstName;
	private String surname;
	private String loginName;
	private int age;
	private String password;
	private String thumbnailURL = "";
	
	
	private LocalDateTime created;
	private User createdBy;
	
	public User() {
		this.uid = GUIDUtil.getUID( User.class.getName() );
		this.created = LocalDateTime.now();
		this.createdBy = null;
	}
		
	public void setUid( String uid ) {
		this.uid = uid;
	}
	
	public void setFirstName( String firstName ) {
		this.firstName = firstName;
	}
	
	public void setSurname( String surname ) {
		this.surname = surname;
	}
	
	public void setLoginName( String loginName ) {
		this.loginName = loginName;
	}
	
	public void setAge( int age ) {
		this.age = age;
	}
	
	public void setPassword( String password ) {
		this.password = password;
	}

	public void setThumbnailURL( String thumbnailURL ) {
		this.thumbnailURL = thumbnailURL;
	}
	
	public String getThumbnailURL() {
		return this.thumbnailURL;
	}

	public String getUid() {
		return this.uid;
	}
	
	public String getFirstName() {
		return this.firstName;
	}
	
	public String getSurname() {
		return this.surname;
	}
	
	public String getLoginName() {
		return this.loginName;
	}
	
	public int getAge() {
		return this.age;
	}
	
	public String getPassword() {
		if( this.password == null )
			return null;
		return this.password;
	}

	@Override
	public User getCreatedBy() {
		// TODO Auto-generated method stub
		return createdBy;
	}

	@Override
	public void setCreatedBy(User u) {
		// TODO Auto-generated method stub
		this.createdBy = u;
		
	}

	@Override
	public LocalDateTime getCreated() {
		// TODO Auto-generated method stub
		return created;
	}

	@Override
	public void setCreated(LocalDateTime created) {
		// TODO Auto-generated method stub
		this.created = created;
		
	}

	@Override
	public void postCreate(User u) {
		// TODO Auto-generated method stub
		setCreated( LocalDateTime.now() );
		setCreatedBy( u );
		if( this.password != null )
			this.password = PasswordUtil.digest( this.password );
		
	}

	@Override
	public void copy(MetaInterface item, MetaInterface alreadyExists ) {
		// TODO Auto-generated method stub
		User u = (User) item;
		User e = (User) alreadyExists;
		this.firstName = u.getFirstName();
		this.surname = u.getSurname();
		this.age = u.getAge();
		if( e == null  ) {
			this.password = u.getPassword();
			this.loginName = u.getLoginName();
		}
		this.thumbnailURL = u.getThumbnailURL();
	}

	@Override
	public ArrayList<String> validate( MetaInterface alreadyExists ) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void delete() {
		//do nothing here override in FaqUser FaqAppUtilManager.getCategoriesSingleton().getUsers().remove(this);
	}

	@Override
	public String getObjectURL(String oid, String view) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getActionURL(String oid, String view, String action) {
		// TODO Auto-generated method stub
		return null;
	}

}
