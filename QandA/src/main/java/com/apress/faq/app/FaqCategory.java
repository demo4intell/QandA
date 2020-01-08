package com.apress.faq.app;

import java.time.LocalDateTime;
import java.util.ArrayList;

import com.apress.faq.common.MetaInterface;
import com.apress.faq.common.User;
import com.apress.faq.util.DataUtil;
import com.apress.faq.util.GUIDUtil;
import com.apress.faq.util.URLUtil;

public class FaqCategory implements MetaInterface {
	
	private String uid;
	private LocalDateTime created;
	private FaqUser createdBy;
	private String name;
	private String imageURL = "";
	
	private ArrayList<FaqQuestion> questions = new ArrayList<FaqQuestion>();
	private ArrayList<TestQuestion> testQuestions = new ArrayList<TestQuestion>();
	
	public FaqCategory() {
		this.uid = GUIDUtil.getUID( FaqCategory.class.getName() );		
	}
	
	public void setName( String name ) {
		this.name = name;
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setImageURL( String imageURL ) {
		this.imageURL = imageURL;
	}
	
	public String getImageURL() {
		return this.imageURL;
	}

	@Override
	public void setUid(String uid) {
		this.uid = uid;		
	}

	@Override
	public String getUid() {
		return this.uid;
	}

	@Override
	public FaqUser getCreatedBy() {
		return this.createdBy;
	}

	@Override
	public void setCreatedBy(User u) {
		this.createdBy = (FaqUser)u;
	}

	@Override
	public LocalDateTime getCreated() {
		return this.created;
	}

	@Override
	public void setCreated(LocalDateTime created) {
		this.created = created;
	}

	@Override
	public void postCreate(User u) {
		this.createdBy = (FaqUser)u;
		this.created = LocalDateTime.now();
		FaqAppUtilManager.getCategoriesSingleton().addCategory(this);
	}

	@Override
	public void copy( MetaInterface item, MetaInterface alreadyExists ) {
		FaqCategory c = (FaqCategory) item;
		this.name = c.getName();
		this.imageURL = c.getImageURL();
	}
	
	public void addQuestion( FaqQuestion q ) {
		this.questions.add(q);
	}
	
	public void removeQuestion( FaqQuestion q ) {
		this.questions.remove(q);
	}
	
	public ArrayList<FaqQuestion> getQuestions() {
		return this.questions;
	}
	
	public FaqQuestion getQuestionObject( String qid ) {
		for( FaqQuestion q : this.questions ) {
			if( q.getUid().equals(qid) )
				return q;
		}
		return null;
	}

	@Override
	public ArrayList<String> validate( MetaInterface alreadyExists ) {
		// TODO Auto-generated method stub
		ArrayList<String> errorMessages = new ArrayList<String>();
		if( DataUtil.isEmptyString( this.getName() ) )
			errorMessages.add("name:Name cannot be empty.");
		else {
			FaqCategory e = (FaqCategory) alreadyExists;
			FaqCategory cat = FaqAppUtilManager.getCategoriesSingleton().getCategoryByName(this.name); 
			if( ( cat != null && e == null ) || 
					( cat != null && e != null && !e.getName().equals( cat.getName() ) ) )
				errorMessages.add("name:Category exists already with this name. Please try another one.");
		}			
		return errorMessages;
	}
	
	@Override
	public String getObjectURL( String oid, String view ) {
		return URLUtil.getObjectURL(oid, view);
	}
	
	@Override
	public String getActionURL( String oid, String view, String action ) {
		//if( action.equals("delete") )
			//return URLUtil.getActionURL( oid, view, action, false );
		//else
			return URLUtil.getActionURL( oid, view, action );
	}
}
