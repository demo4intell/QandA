package com.apress.faq.app;

import java.time.LocalDateTime;
import java.util.ArrayList;

import com.apress.faq.common.MetaInterface;
import com.apress.faq.common.User;
import com.apress.faq.util.GUIDUtil;
import com.apress.faq.util.URLUtil;

public class Questionnaire implements MetaInterface {

	private String uid;
	private FaqUser createdBy;
	private LocalDateTime created;
	private String status = "Not Started"; //Not Taken, Started, Completed
	
	private ArrayList<FaqCategory> categories = new ArrayList<>();	
	public ArrayList<TestQuestion> questions = new ArrayList<TestQuestion>();
		
	public Questionnaire() {
		this.uid = GUIDUtil.getUID( Questionnaire.class.getName() );		
	}
	
	@Override
	public void setUid(String uid) {
		this.uid = uid;
	}

	@Override
	public String getUid() {
		// TODO Auto-generated method stub
		return uid;
	}

	@Override
	public FaqUser getCreatedBy() {
		// TODO Auto-generated method stub
		return this.createdBy;
	}

	@Override
	public void setCreatedBy(User u) {
		// TODO Auto-generated method stub
		this.createdBy = (FaqUser)u;		
	}

	@Override
	public LocalDateTime getCreated() {
		// TODO Auto-generated method stub
		return this.created;
	}

	@Override
	public void setCreated(LocalDateTime created) {
		// TODO Auto-generated method stub
		this.created = created;		
	}
	
	public void setStatus( String status ) {
		this.status = status;
	}
	
	public String getStatus() {
		return this.status;
	}

	@Override
	public ArrayList<String> validate(MetaInterface alreadyExists) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void postCreate(User u) {
		// TODO Auto-generated method stub
		this.created = LocalDateTime.now();
		this.createdBy = (FaqUser) u;
		
	}

	@Override
	public void copy(MetaInterface item, MetaInterface alreadyExists) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getObjectURL(String oid, String view) {
		// TODO Auto-generated method stub
		return URLUtil.getObjectURL(oid, view) + "&useruid=" + this.getCreatedBy().getUid();
	}

	@Override
	public String getActionURL(String oid, String view, String action) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public ArrayList<TestQuestion> getQuestions() {
		return this.questions;
	}
	
	public void setQuestions( ArrayList<TestQuestion> questions ) {
		this.questions = questions;
	}
	
	public void addQuestion( TestQuestion question ) {
		this.questions.add( question );
	}
	
	public void setCategories( ArrayList<FaqCategory> categories ) {
		this.categories = categories;
	}
	
	public ArrayList<FaqCategory> getCategories() {
		return this.categories;
	}
	
	public void addCategory( FaqCategory category ) {
		this.categories.add(category);
	}
}
