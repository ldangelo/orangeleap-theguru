package com.mpower.dao;

import java.util.List;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportCustomFilterDefinition;
import com.mpower.domain.ReportFieldGroup;

public interface ReportCustomFilterDefinitionDao {
	public ReportCustomFilterDefinition findById(long Id);

	public List<ReportCustomFilterDefinition> getAll();
	public List<ReportCustomFilterDefinition> getAllByReportDataSubSourceId(Long id);
	public void save(ReportCustomFilterDefinition customFilter);

	public ReportCustomFilterDefinition update(ReportCustomFilterDefinition customFilter);
	public ReportCustomFilterDefinition copy(ReportCustomFilterDefinition customFilter);
	
	public void delete(ReportCustomFilterDefinition customFilter);
}
