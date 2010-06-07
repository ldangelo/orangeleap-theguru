package com.mpower.service;

import java.util.List;

import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportCustomFilterDefinition;

public interface ReportCustomFilterDefinitionService {
	public List<ReportCustomFilterDefinition> readReportCustomFilterDefinitionBySubSourceId(Long l);
	
	public void save(ReportCustomFilterDefinition reportCustomFilterDefinition);

	public ReportCustomFilterDefinition find(Long Id);

}
