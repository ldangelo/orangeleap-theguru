package com.mpower.domain.dwr;

import java.lang.String;

public class ReportDataSubSourceGroup {
	private long id;
	private String displayName;
	private String description;

	public ReportDataSubSourceGroup(com.mpower.domain.ReportDataSubSourceGroup rdss) {
		id = rdss.getId();
		displayName = rdss.getDisplayName();
		description = rdss.getDescription();
	}

	public long getId() {
		return id;
	}

	public String getDisplayName() {
		return displayName;
	}

	public String getDescription() {
		return description;
	}
}