package com.mpower.dao;

import java.util.List;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportFieldGroup;

public interface ReportFieldGroupDao {
	public ReportFieldGroup findById(long Id);

	public List<ReportFieldGroup> getAll();
	public List<ReportFieldGroup> getAllByReportDataSubSourceId(Long id);
	public void save(ReportFieldGroup group);

	public ReportFieldGroup update(ReportFieldGroup group);
	public ReportFieldGroup copy(ReportFieldGroup group);
	
	public void delete(ReportFieldGroup group);
}
