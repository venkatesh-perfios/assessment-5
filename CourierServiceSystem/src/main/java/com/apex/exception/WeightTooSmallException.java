package com.apex.exception;

public class WeightTooSmallException extends Exception {
	private static final long serialVersionUID = 1L;
	
	public WeightTooSmallException(String msg) {
		super(msg);
	}
}
