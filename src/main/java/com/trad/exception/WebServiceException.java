package com.trad.exception;

public class WebServiceException extends Throwable{

	private static final long serialVersionUID = 1L;

	public WebServiceException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public WebServiceException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public WebServiceException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public WebServiceException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public String getLocalizedMessage() {
		return super.getLocalizedMessage();
	}

	@Override
	public String getMessage() {
		return super.getMessage();
	}

}
