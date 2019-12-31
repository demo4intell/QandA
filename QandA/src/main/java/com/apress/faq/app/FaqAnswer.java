package com.apress.faq.app;

import java.time.LocalDateTime;
import java.util.ArrayList;

import com.apress.faq.common.MetaInterface;
import com.apress.faq.common.User;
import com.apress.faq.util.DataUtil;
import com.apress.faq.util.GUIDUtil;
import com.apress.faq.util.URLUtil;

public class FaqAnswer implements MetaInterface {
	
	private String uid;
	private LocalDateTime created;
	private FaqUser createdBy;
	
	private String text;
	private FaqQuestion question;
	
	public FaqAnswer() {
		this.uid = GUIDUtil.getUID( FaqAnswer.class.getName() );
	}
	
	
	public void setText( String text ) {
		this.text = text;
	}
	
	public String getText() {
		return this.text;
	}
	
	public void setQuestion( FaqQuestion question ) {
		this.question = question;
	}
	
	public FaqQuestion getQuestion() {
		return this.question;
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
		if( getQuestion() != null )
			getQuestion().addAnswer(this);
	}

	@Override
	public void copy(MetaInterface item, MetaInterface alreadyExists) {
		FaqAnswer a = (FaqAnswer) item;
		this.setText( a.getText() );
	}


	@Override
	public ArrayList<String> validate( MetaInterface alreadyExists ) {
		ArrayList<String> errorMessages = new ArrayList<String>();
		if( DataUtil.isEmptyString( this.getText() ) )
			errorMessages.add("Answer text cannot be empty.");
		return errorMessages;
	}
	
	@Override
	public String getObjectURL( String oid, String view ) {
		return URLUtil.getObjectURL(oid, view) + "&quesuid=" + this.getQuestion().getUid() + "&catuid=" + this.getQuestion().getCategory().getUid();
	}
	
	@Override
	public String getActionURL( String oid, String view, String action ) {
		return URLUtil.getActionURL( oid, view, action ) + "&quesuid=" + this.getQuestion().getUid() + "&catuid=" + this.getQuestion().getCategory().getUid();
	}

}
