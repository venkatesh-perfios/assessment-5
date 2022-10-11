package com.apex.view;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.utils.SessionUtils;

@WebServlet("/view-page/view")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		SessionUtils.updateSessionAttributes(request);
		request.getSession().setAttribute("refresh", false);
		
		response.setContentType("text/html");
		
		String trackingID = request.getParameter("track");
		
		try {
			ResultSet resultSet = ViewDao.getOrders(trackingID);
			
			if (!resultSet.next()) {
				request.getSession().setAttribute("trackException", "Track ID doesn't exist!");
			} else {
				request.getSession().setAttribute("order", resultSet);
			}
		} catch(Exception e) {
			request.getSession().setAttribute("otherException", "Unable to track your order at the moment! "
					+ "Try again later!");
		} finally {
			request.getRequestDispatcher("view.jsp").include(request, response);
		}
	}
}
