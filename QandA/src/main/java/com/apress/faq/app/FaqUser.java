package com.apress.faq.app;

import java.util.ArrayList;

import com.apress.faq.common.MetaInterface;
import com.apress.faq.common.User;
import com.apress.faq.util.DataUtil;
import com.apress.faq.util.GUIDUtil;
import com.apress.faq.util.URLUtil;

public class FaqUser extends User implements MetaInterface {

	private String[] topics;
	private int score;
	private ArrayList<FaqCategory> categories = new ArrayList<FaqCategory>();
	private ArrayList<Questionnaire> questionnaires = new ArrayList<Questionnaire>();
	
	public FaqUser() {
		this.uid = GUIDUtil.getUID( FaqUser.class.getName() );
	}
	
	public void setScore( int score ) {
		this.score = score;
	}
	
	public int getScore() {
		return this.score;
	}
		
	public void setTopics( String[] topics ) {
		this.topics = topics;
	}
	
	public String[] getTopics() {
		return this.topics;
	}
	
	public void addCategory( FaqCategory cat ) {
		this.categories.add(cat);
	}
	
	public void removeCategory( FaqCategory cat ) {
		this.categories.remove(cat);
	}
	
	public ArrayList<FaqCategory> getCategoryTopics() {
		return this.categories;
	}
	
	public boolean hasSelectedCategory( String cid ) {
		for( FaqCategory cat : categories ) {
			if( cat.getUid().equals(cid) )
				return true;
		}
		return false;
	}
	
	@Override
	public void postCreate(User u) {
		super.postCreate(u);
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		faqs.addUser(this);
	}
	
	public void updateCategoryTopics() {
		System.out.println(">>>topics "+topics);
		FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
		
		if( topics != null ) {
			for( String topic : topics ) {
				for( FaqCategory cat : faqs.getCategories() ) {
					if( topic.equals( cat.getUid() ) && !this.hasSelectedCategory(cat.getUid()) )
						this.categories.add(cat);
				}
			}
		}
	}

	@Override
	public void copy( MetaInterface item, MetaInterface alreadyExists ) {
		// TODO Auto-generated method stub

		super.copy(item, alreadyExists);
		FaqUser u = (FaqUser) item;
		this.categories.removeAll(this.categories);
		for( FaqCategory cat : u.getCategoryTopics() ) {
			this.categories.add(cat);
		}
		//update topics
	}
	
	@Override
	public ArrayList<String> validate( MetaInterface alreadyExists ) {
		ArrayList<String> errorMessages = new ArrayList<String>();
		//if any of the fields empty send a message cannot be left empty
		if( this.getFirstName() == null || this.getFirstName().length() == 0 )
			errorMessages.add("firstName:First name cannot be empty.");
		if( this.getSurname() == null || this.getSurname().length() == 0 )
			errorMessages.add("surname:Surname cannot be empty.");
		if( this.getAge() > 100 || this.getAge() < 18 )
			errorMessages.add("age:Age needs to be a number greater than or equal to 18.");
		
		if( alreadyExists == null ) {
			if( this.getLoginName() == null || this.getLoginName().length() == 0 )
				errorMessages.add("loginName:Login name cannot be empty.");
			if( this.getPassword() == null || this.getPassword().length() == 0 )
				errorMessages.add("password:Password cannot be empty.");
			FaqAppUtilManager faqs = FaqAppUtilManager.getCategoriesSingleton();
			for( FaqUser u : faqs.getUsers() ) {
				if( this.getLoginName() != null && this.getLoginName().equals(u.getLoginName()) )
					errorMessages.add("loginName:Login Name already exists. Please choose another one.");
			}
		}		
		return errorMessages;		
	}
	
	@Override
	public String getObjectURL( String oid, String view ) {
		return URLUtil.getObjectURL(oid, view);
	}
	
	@Override
	public String getActionURL( String oid, String view, String action ) {
		return URLUtil.getActionURL( oid, view, action );
	}


}
