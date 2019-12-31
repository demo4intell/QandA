package com.apress.faq.common;

import java.time.LocalDateTime;
import java.util.ArrayList;

import com.apress.faq.util.PasswordUtil;

public class LoginInfo implements MetaInterface {
	
	private String loginId;
	private String password;
	private String oldPassword;
	private String type = "Login";
	
	public void setLoginId( String loginId ) {
		this.loginId = loginId;
	}
	
	public void setOldPassword( String oldPassword ) {
		this.oldPassword = oldPassword;
	}
	
	public void setType( String type ) {
		this.type = type;
	}
	
	public String getType() {
		return this.type;
	}
	
	public String getOldPassword( ) {
		return this.oldPassword;
	}
	
	public String getLoginId() {
		return this.loginId;
	}
	
	public void setPassword( String password ) {
		this.password = password;
	}
	
	public String getPassword( ) {
		return this.password;
	}

	@Override
	public void setUid(String uid) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getUid() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User getCreatedBy() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setCreatedBy(User u) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public LocalDateTime getCreated() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setCreated(LocalDateTime created) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postCreate(User u) {
		// TODO Auto-generated method stub
		if( this.password != null )
			this.password = PasswordUtil.digest(this.password);
		if( this.oldPassword != null )
			this.oldPassword = PasswordUtil.digest(this.oldPassword);
		else
			this.oldPassword = "";
		
	}

	@Override
	public void copy(MetaInterface item, MetaInterface alreadyExists ) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ArrayList<String> validate( MetaInterface alreadyExists ) {
		// TODO Auto-generated method stub
		return null;
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
