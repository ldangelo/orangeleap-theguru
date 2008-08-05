package com.mpower.service;

import java.util.SortedSet;

import com.mpower.domain.ReportDataSource;

public interface ReportSourceService {
	public SortedSet<ReportDataSource> readSources();

	public void save(ReportDataSource datasource);

	public ReportDataSource find(Long Id);

}
