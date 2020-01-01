package com.apress.faq.app;

public interface TestQuestion {
	
	public String getText();
	public void setText( String text );
	
	public int getCredits();
	public void setCredits( int credits );
	
	public void setAnswer( TestAnswer answer );
	public TestAnswer getAnswer();
	
	public void setCreatedFrom( TestQuestion question );
	public TestQuestion getCreatedFrom();
	
	public void setCategory( FaqCategory category );
	public FaqCategory getCategory();

}
