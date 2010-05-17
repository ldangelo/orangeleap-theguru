package com.mpower.dao;

import java.util.List;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSourceGroup;

public interface ReportDataSubSourceGroupDao {
	public ReportDataSubSourceGroup findById(long Id);

	public List<ReportDataSubSourceGroup> getAll();
	public List<ReportDataSubSourceGroup> getAllByReportSourceId(Long id);
	
	public void save(ReportDataSubSourceGroup dataSubSourceGroup);
	public ReportDataSubSourceGroup copy(ReportDataSubSourceGroup dataSubSourceGroup);
	
	public ReportDataSubSourceGroup update(ReportDataSubSourceGroup dataSubSourceGroup);

	public void delete(ReportDataSubSourceGroup dataSubSourceGroup);
}
