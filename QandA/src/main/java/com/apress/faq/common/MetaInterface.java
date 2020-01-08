package com.apress.faq.common;

import java.time.LocalDateTime;
import java.util.ArrayList;

public interface MetaInterface {
	
	public void setUid( String uid );
	public String getUid();
	
	public User getCreatedBy( );
	public void setCreatedBy( User u );
	
	public LocalDateTime getCreated();
	public void setCreated( LocalDateTime created );
	
	public ArrayList<String> validate( MetaInterface alreadyExists );
	public void delete();
	
	public void postCreate( User u );
	
	public void copy( MetaInterface item, MetaInterface alreadyExists );
	
	public String getObjectURL( String oid, String view );
	
	public String getActionURL( String oid, String view, String action );

}
