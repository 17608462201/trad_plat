package com.trad.exception;

public class TradBusinessException extends BaseException{
	
	private static final long serialVersionUID = -7385807283502503444L;

	public TradBusinessException() {
		super();
	}

	public TradBusinessException(String message, Throwable cause) {
		super(message, cause);
	}

	public TradBusinessException(String message) {
		super(message);
	}

	public TradBusinessException(Throwable cause) {
		super(cause);
	}
	

}
