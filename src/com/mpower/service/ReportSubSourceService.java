package com.mpower.service;

import java.util.List;


import com.mpower.domain.ReportDataSubSource;

public interface ReportSubSourceService {
	public List<ReportDataSubSource> readSubSourcesByReportSubSourceGroupId(Long l);

	public void save(ReportDataSubSource datasource);

	public ReportDataSubSource find(Long Id);

}
