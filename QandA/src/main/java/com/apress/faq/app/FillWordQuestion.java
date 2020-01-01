package com.apress.faq.app;

public class FillWordQuestion implements TestQuestion {
	
	private String text;
	private int credits;
	private FaqCategory category;
	private FillWordAnswer answer;
	private FillWordQuestion createdFrom;

	@Override
	public String getText() {
		// TODO Auto-generated method stub
		return this.text;
	}

	@Override
	public void setText(String text) {
		// TODO Auto-generated method stub
		this.text = text;		
	}

	@Override
	public int getCredits() {
		// TODO Auto-generated method stub
		return this.credits;
	}

	@Override
	public void setCredits(int credits) {
		// TODO Auto-generated method stub
		this.credits = credits;
	}

	@Override
	public void setAnswer(TestAnswer answer) {
		// TODO Auto-generated method stub
		this.answer = (FillWordAnswer)answer;
	}

	@Override
	public TestAnswer getAnswer() {
		// TODO Auto-generated method stub
		return this.answer;
	}

	@Override
	public void setCreatedFrom(TestQuestion question) {
		// TODO Auto-generated method stub
		this.createdFrom = (FillWordQuestion) question;
	}

	@Override
	public TestQuestion getCreatedFrom() {
		// TODO Auto-generated method stub
		return this.createdFrom;
	}

	@Override
	public void setCategory(FaqCategory category) {
		// TODO Auto-generated method stub
		this.category = category;
	}

	@Override
	public FaqCategory getCategory() {
		// TODO Auto-generated method stub
		return this.category;
	}

}