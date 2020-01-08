package com.apress.faq.app;

import java.time.LocalDateTime;
import java.util.ArrayList;

import com.apress.faq.common.MetaInterface;
import com.apress.faq.common.User;
import com.apress.faq.util.DataUtil;
import com.apress.faq.util.GUIDUtil;
import com.apress.faq.util.URLUtil;

public class FaqQuestion implements MetaInterface {
	
	private String uid;
	private LocalDateTime created;
	private FaqUser createdBy;
	private String text;
	
	private FaqCategory category;
	
	private ArrayList<FaqAnswer> answers = new ArrayList<FaqAnswer>();
	
	public FaqQuestion() {
		this.uid = GUIDUtil.getUID( FaqQuestion.class.getName() );
	}
	
	public void setText( String text ) {
		this.text = text;
	}
	
	public String getText() {
		return this.text;
	}
	
	public void setCategory( FaqCategory cat ) {
		this.category = cat;
	}
	
	public FaqCategory getCategory() {
		return this.category;
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
	public User getCreatedBy() {
		return this.createdBy;
	}

	@Override
	public void setCreatedBy(User u) {
		this.createdBy = (FaqUser) u;
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
		this.createdBy = (FaqUser) u;
		this.created = LocalDateTime.now();
		if( getCategory() != null )
			getCategory().addQuestion(this);
	}

	@Override
	public void copy(MetaInterface item, MetaInterface alreadyExists) {
		FaqQuestion q = (FaqQuestion) item;
		this.text = q.getText();
	}
	
	public void addAnswer( FaqAnswer a ) {
		this.answers.add(a);
	}
	
	public void removeAnswer( FaqAnswer a ) {
		a.setQuestion(null);
		this.answers.remove(a);
	}
	
	public ArrayList<FaqAnswer> getAnswers() {
		return this.answers;
	}
	
	public FaqAnswer getAnswerObject( String aid ) {
		for( FaqAnswer a : this.answers ) {
			if( a.getUid().equals(aid) )
				return a;
		}
		return null;
	}

	@Override
	public ArrayList<String> validate( MetaInterface alreadyExists ) {
		// TODO Auto-generated method stub
		ArrayList<String> errorMessages = new ArrayList<String>();
		if( DataUtil.isEmptyString( this.getText() ) )
			errorMessages.add("text:Question text cannot be empty.");
		return errorMessages;
	}
	
	@Override
	public String getObjectURL( String oid, String view ) {
		return URLUtil.getObjectURL(oid, view) + "&catuid="+this.getCategory().getUid();
	}
	
	@Override
	public String getActionURL( String oid, String view, String action ) {
		String returnURL = "&catuid=" + this.getCategory().getUid();
		//if( action.equals("delete") )
			//return URLUtil.getActionURL( oid, view, action, false ) + returnURL;
		//else
			return URLUtil.getActionURL( oid, view, action ) + returnURL;
	}

}
