package com.mpower.service;

import java.util.List;
import java.util.Map;

import com.mpower.domain.ReportDataSource;

public interface ReportSourceService {
	public List<ReportDataSource> readSources();

	public void save(ReportDataSource datasource);

	public ReportDataSource find(Long Id);

}
