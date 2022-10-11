package com.apex.order;

import java.sql.ResultSet;
import java.sql.Statement;

import com.apex.model.OrderInfo;
import com.apex.utils.DatabaseUtils;

public class OrderDao {
	private static final String ORDERS_TABLE_NAME = "Orders";
	private static final String DISTANCES_TABLE_NAME = "Distances";
	
	public static int placeOrder(OrderInfo orderInfo) throws Exception {
		String placeOrderSql = "insert into " + ORDERS_TABLE_NAME + " values('" + orderInfo.getName() + "', " + 
				orderInfo.getPhone() + ", '" + orderInfo.getSource() + "', '" + orderInfo.getDestination() + 
				"', " + orderInfo.getDistance() + ", " + orderInfo.getWeight() + ", " + orderInfo.getAmount() + 
				", '" + orderInfo.getTrackingId() + "', '" + orderInfo.getDateOfShipment() + "', '" + 
				orderInfo.getDateOfDelivery() + "')";
		Statement statement = DatabaseUtils.getConnection().createStatement();
		
		return statement.executeUpdate(placeOrderSql);
	}
	
	public static ResultSet getDistanceByCities(OrderInfo orderInfo) throws Exception {
		String getDistanceByCitiesSql = "select * from " + DISTANCES_TABLE_NAME + " where Source='" + 
				orderInfo.getSource() + "' and Destination='" + orderInfo.getDestination() + "' or Source='" + 
				orderInfo.getDestination() + "' and Destination='" + orderInfo.getSource() + "'";
		Statement statement = DatabaseUtils.getConnection().createStatement();
		
		return statement.executeQuery(getDistanceByCitiesSql);
	}

	public static ResultSet getMaxTrackingId() throws Exception {
		String maxTrackingIdSql = "select max(Tracking_ID) from " + ORDERS_TABLE_NAME;
		Statement statement = DatabaseUtils.getConnection().createStatement();
		
		return statement.executeQuery(maxTrackingIdSql);
	}
}
