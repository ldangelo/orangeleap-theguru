package com.mpower.service;

import java.util.List;


import com.mpower.domain.ReportDataSubSourceGroup;

public interface ReportSubSourceGroupService {
	public List<ReportDataSubSourceGroup> readSubSourceGroupsByReportSourceId(Long l);

	public void save(ReportDataSubSourceGroup datasource);

	public ReportDataSubSourceGroup find(Long Id);

}
