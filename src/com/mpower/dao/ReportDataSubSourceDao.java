package com.mpower.dao;

import java.util.List;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;

public interface ReportDataSubSourceDao {
	public ReportDataSubSource findById(long Id);

	public List<ReportDataSubSource> getAll();
	public List<ReportDataSubSource> getAllByReportSubSourceGroupId(Long id);
	
	public void save(ReportDataSubSource datasubsource);
	public ReportDataSubSource copy(ReportDataSubSource datasubsource);
	
	public ReportDataSubSource update(ReportDataSubSource datasubsource);

	public void delete(ReportDataSubSource datasubsource);
}
