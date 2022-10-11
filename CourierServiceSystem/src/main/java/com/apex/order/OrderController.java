package com.apex.order;

import java.io.IOException;

import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.exception.NameInvalidException;
import com.apex.exception.NameTooLongException;
import com.apex.exception.PhoneInvalidException;
import com.apex.exception.SourceSameAsDestinationException;
import com.apex.exception.WeightInvalidException;
import com.apex.exception.WeightTooLargeException;
import com.apex.exception.WeightTooSmallException;
import com.apex.model.OrderInfo;
import com.apex.utils.SessionUtils;

@WebServlet("/order-page/order")
public class OrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		Double calculatedAmount = (Double) request.getSession().getAttribute("amount");

		SessionUtils.updateSessionAttributes(request);
		request.getSession().setAttribute("refresh", false);
		
		response.setContentType("text/html");
		
		String name = request.getParameter("name");
		long phone = Long.parseLong(request.getParameter("phone"));
		String source = request.getParameter("source");
		String destination = request.getParameter("destination");
		double weight = Double.parseDouble(request.getParameter("weight"));
		
		OrderInfo orderInfo = new OrderInfo();
		orderInfo.setName(name);
		orderInfo.setPhone(phone);
		orderInfo.setSource(source);
		orderInfo.setDestination(destination);
		orderInfo.setWeight(weight);
		
		if (calculatedAmount != null) {
			orderInfo.setAmount(calculatedAmount);
			
			try {
				ResultSet resultSet = OrderDao.getDistanceByCities(orderInfo);
				resultSet.next();
				orderInfo.setDistance(resultSet.getInt("Distance"));
				orderInfo.setTrackingId(generateTrackingId());
				orderInfo.setDateOfShipment(getDateOfShipment());
				orderInfo.setDateOfDelivery(getDateOfDelivery(orderInfo));
				
				if (OrderDao.placeOrder(orderInfo) != 1) {
					request.getSession().setAttribute("otherException", "Unable to place your order at the moment! "
							+ "Try again later!");
					request.getRequestDispatcher("order.jsp").include(request, response);
				} else {
					request.getSession().setAttribute("success", "Your order has been placed successfully!"
							+ "<br>"
							+ "Here's your order tracking ID for future reference: " + orderInfo.getTrackingId());
					request.getRequestDispatcher("order.jsp").include(request, response);
				}
			} catch (Exception e) {
				request.getSession().setAttribute("otherException", "Unable to place your order at the moment! "
						+ "Try again later!");
				request.getRequestDispatcher("order.jsp").include(request, response);
			}
		} else {
			try {
				OrderService orderService = new OrderService();
				double amount = orderService.placeOrder(orderInfo);
				request.getSession().setAttribute("amount", amount);
			} catch(NameInvalidException | NameTooLongException nameExceptions) {
				request.getSession().setAttribute("nameException", nameExceptions.getMessage());
			} catch(PhoneInvalidException phoneInvalidException) {
				request.getSession().setAttribute("phoneException", phoneInvalidException.getMessage());
			} catch(SourceSameAsDestinationException sourceSameAsDestinationException) {
				request.getSession().setAttribute("destinationException", sourceSameAsDestinationException.getMessage());
			} catch (WeightInvalidException | WeightTooSmallException | WeightTooLargeException weightExceptions) {
				request.getSession().setAttribute("weightException", weightExceptions.getMessage());
			} catch (Exception e) {
				request.getSession().setAttribute("otherException", "Unable to place your order at the moment! "
						+ "Try again later!");
			} finally {
				request.getRequestDispatcher("order.jsp").include(request, response);
			}
		}
	}
	
	private String generateTrackingId() throws Exception {
		final String BASE_ACCOUNT_NUMBER = "ACIN";
		final long HUNDRED_CRORES = 100_00_00_000;
		ResultSet resultSet = OrderDao.getMaxTrackingId();
		resultSet.next();
		
		String maxAccountNumber = resultSet.getString(1);
		String newAccountNumber;
		if (maxAccountNumber == null) {
			newAccountNumber = BASE_ACCOUNT_NUMBER + HUNDRED_CRORES;
		} else {
			newAccountNumber = BASE_ACCOUNT_NUMBER + (Long.parseLong(maxAccountNumber.substring(4)) + 1);
		}
		
		return newAccountNumber;
	}
	
	private String getDateOfShipment() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, 1);
		
		return dateFormat.format(calendar.getTime());
	}
	
	private String getDateOfDelivery(OrderInfo orderInfo) throws Exception {
		double distance = orderInfo.getDistance();
		
		int numberOfDays;
    	if (distance <= 1000) {
    		numberOfDays = 3;
    	} else if (distance <= 1500) {
    		numberOfDays = 6;
    	} else if (distance <= 2000) {
    		numberOfDays = 8;
    	} else {
    		numberOfDays = 10;
    	}
    	
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(orderInfo.getDateOfShipment()));
		calendar.add(Calendar.DATE, numberOfDays);
		
		return dateFormat.format(calendar.getTime());
	}
}
