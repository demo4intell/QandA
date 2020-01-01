package com.apress.faq.app;

public class FillWordAnswer implements TestAnswer {
	
	private FillWordQuestion question;
	private String text;
	
	public void setText( String text ) {
		this.text = text;
	}

	public String getText() {
		return this.text;
	}
	
	@Override
	public void setQuestion(TestQuestion question) {
		// TODO Auto-generated method stub
		this.question = (FillWordQuestion) question;		
	}

	@Override
	public TestQuestion getQuestion() {
		// TODO Auto-generated method stub
		return this.question;
	}

}