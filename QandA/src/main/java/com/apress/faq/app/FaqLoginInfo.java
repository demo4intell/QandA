package com.apress.faq.app;

import java.util.ArrayList;

import com.apress.faq.common.*;
import com.apress.faq.util.DataUtil;;



public class FaqLoginInfo extends LoginInfo {

	private FaqUser loggedIn;
	
	public void setLoggedIn( FaqUser loggedIn ) {
		this.loggedIn = loggedIn;
	}
	
	public FaqUser getLoggedIn() {
		return this.loggedIn;
	}
	
	@Override
	public ArrayList<String> validate( MetaInterface alreadyExists ) {
		ArrayList<String> errorMessages = new ArrayList<String>();
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		System.out.println(">>>old password "+this.getOldPassword());
		if( !this.getType().equals("Login") ) {
			//login name will be present - get the user
			setLoggedIn( faqs.getUserByLogin(this.getLoginId()) );
			boolean isEmptyPassword = DataUtil.isEmptyString(this.getPassword());
			boolean isEmptyOldPassword = DataUtil.isEmptyString(this.getOldPassword());
			if( isEmptyPassword || isEmptyOldPassword ) {
				if( isEmptyPassword )
					errorMessages.add("Password cannot be empty.");
				if( isEmptyOldPassword )
					errorMessages.add("Old Password cannot be empty.");
			} else {
				if( this.getLoggedIn()!= null && !isEmptyPassword && !isEmptyOldPassword &&
					!this.getLoggedIn().getPassword().equals( this.getOldPassword() ) ) {
					setLoggedIn( null );
					errorMessages.add("The old password does not match the current password. Password cannot be changed.");
				}
			}			
		} else {
			boolean isEmptyLoginId = DataUtil.isEmptyString(this.getLoginId());
			boolean isEmptyPassword = DataUtil.isEmptyString(this.getPassword());
			if( isEmptyLoginId )
				errorMessages.add("Login Name cannot be empty.");
			if( isEmptyPassword )
				errorMessages.add("Password cannot be empty.");
			setLoggedIn( faqs.getUserByLogin(this.getLoginId()) );
			System.out.println(">>>password "+this.getPassword()+","+(getLoggedIn() != null ? getLoggedIn().getPassword():""));
			if( !isEmptyLoginId && !isEmptyPassword && this.getLoggedIn() == null )
				errorMessages.add("User with the login id does not exist. If you wish to login, please sign up.");
			if( !isEmptyLoginId && !isEmptyPassword && this.getLoggedIn() != null &&
					!this.getLoggedIn().getPassword().equals(this.getPassword()) ) {
				setLoggedIn( null );
				errorMessages.add("Login Id and password does not match. Please enter the correct password.");
			}
		}
		return errorMessages;
	}
}
