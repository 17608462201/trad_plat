package com.trad.exception;

public class JsonException extends Throwable{

	private static final long serialVersionUID = 1L;

	public JsonException() {
		super();
	}
	
	public JsonException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public JsonException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public JsonException(Throwable cause) {
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
