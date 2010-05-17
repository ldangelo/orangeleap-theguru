package com.mpower.util;

import javax.servlet.http.HttpSession;

import com.mpower.domain.GuruSessionData;

public class SessionHelper {

	public static ThreadLocal<HttpSession> tl_data = new ThreadLocal<HttpSession>() {
		protected synchronized HttpSession initialValue() {
			return null;
		}
	};

	public static GuruSessionData getGuruSessionData() {
		GuruSessionData guruSessionData = (GuruSessionData) tl_data.get()
				.getAttribute("GURUSESSIONDATA");
		if (guruSessionData == null) {
			guruSessionData = new GuruSessionData();
			tl_data.get().setAttribute("GURUSESSIONDATA", guruSessionData);
		}
		return (GuruSessionData) guruSessionData;
	}
}
