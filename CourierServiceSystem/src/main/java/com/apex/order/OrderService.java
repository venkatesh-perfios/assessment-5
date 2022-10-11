package com.apex.order;

import java.sql.ResultSet;
import java.util.regex.Pattern;

import com.apex.exception.NameInvalidException;
import com.apex.exception.NameTooLongException;
import com.apex.exception.PhoneInvalidException;
import com.apex.exception.SourceSameAsDestinationException;
import com.apex.exception.WeightInvalidException;
import com.apex.exception.WeightTooLargeException;
import com.apex.exception.WeightTooSmallException;
import com.apex.model.OrderInfo;

public class OrderService {
	public double placeOrder(OrderInfo orderInfo) throws NameInvalidException, NameTooLongException, 
			PhoneInvalidException, SourceSameAsDestinationException, WeightInvalidException, 
			WeightTooSmallException, WeightTooLargeException, Exception {
		String msg;
		
		if (isStringInvalid(orderInfo.getName())) {
			msg = "Please enter a valid name!";
			throw new NameInvalidException(msg);
		}
		
		if (isNameTooLong(orderInfo.getName())) {
			msg = "Your name is too long! Please ensure that it has no more than 1000 characters";
			throw new NameTooLongException(msg);
		}
		
		if (isPhoneInvalid(orderInfo.getPhone())) {
			msg = "Please enter a valid, 10-digit phone number!<br>Do not enter the country code or any special " +
			  "characters (such as spaces, hyphens, parentheses etc).";
			throw new PhoneInvalidException(msg);
		}
		
		if (isSourceSameAsDestination(orderInfo)) {
			msg = "The source and destination cities cannot be the same!";
			throw new SourceSameAsDestinationException(msg);
		}
		
		if (isNumberInvalid(orderInfo.getWeight())) {
			msg = "Please enter a valid amount weight! Here are some tips:<br>" +
					  "1. Don't enter any alphabet or special character<br>" +
					  "2. Don't enter 0 as the package's weight<br>" +
					  "3. Don't enter more than 2 numbers after the decimal point";
			throw new WeightInvalidException(msg);
		}
		
		if (isWeightTooSmall(orderInfo.getWeight())) {
			msg = "The package must have a minimum weight of 10 grams!";
			throw new WeightTooSmallException(msg);
		}
		
		if (isWeightTooLarge(orderInfo.getWeight())) {
			msg = "The package must have a maximum weight of 100000 grams!";
			throw new WeightTooLargeException(msg);	
		}

		ResultSet resultSet = OrderDao.getDistanceByCities(orderInfo);
		if (!resultSet.next()) {
			throw new Exception();
		}
		orderInfo.setDistance(resultSet.getInt("Distance"));
		
		return getAmount(orderInfo);
	}

	private boolean isStringInvalid(String name) {
		final String ALLOWED_SPECIAL_CHARACTERS = " .-";
		name = name.toLowerCase();
		
		for (int i = 0; i < name.length(); ++i) {
			char currentCharacter = name.charAt(i);
			
			if (!(currentCharacter >= 'a' && currentCharacter <= 'z') && (ALLOWED_SPECIAL_CHARACTERS.indexOf(currentCharacter) < 0))
				return true;
		}
		
		return false;
	}

	private boolean isNameTooLong(String name) {
		return name.length() > 1000;
	}
	
	private boolean isPhoneInvalid(long phone) {
		return !Pattern.matches("^\\d{10}$", Long.toString(phone));
	}

	private boolean isSourceSameAsDestination(OrderInfo orderInfo) {
		return orderInfo.getSource().equals(orderInfo.getDestination());
	}
	
    private boolean isNumberInvalid(double weight) {
        return !(Pattern.matches("^\\d+[.]?\\d*$", Double.toString(weight))
                && weight != 0.0 && Double.toString(weight).split("\\.")[1].length() <= 2);
    }
    
    private boolean isWeightTooSmall(double weight) {
    	return weight < 10.0;
    }
    
    private boolean isWeightTooLarge(double weight) {
    	return weight > 100000.0;
    }
    
    private double getAmount(OrderInfo orderInfo) {
    	int distance = orderInfo.getDistance();
    	
    	double amountPerGm;
    	if (distance <= 50) {
    		amountPerGm = 1;
    	} else {
    		amountPerGm = 1 + (0.01 * (distance - 50));
    	}
    	
    	return amountPerGm * orderInfo.getWeight();
    }
}
