package com.mpower.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportCustomFilterDefinitionDao;
import com.mpower.domain.ReportCustomFilterDefinition;

@Service("reportCustomFilterDefinitionService")
public class ReportCustomFilterDefinitionServiceImpl implements ReportCustomFilterDefinitionService {
	@Resource(name = "reportCustomFilterDefinitionDao")
	private ReportCustomFilterDefinitionDao reportCustomFilterDefinitionDao;

	public ReportCustomFilterDefinition find(Long Id) {		
		return reportCustomFilterDefinitionDao.findById(Id);
	}

	public List<ReportCustomFilterDefinition> readReportCustomFilterDefinitionBySubSourceId(Long l) {
		return reportCustomFilterDefinitionDao.getAllByReportDataSubSourceId(l);
	}

	public void save(ReportCustomFilterDefinition reportCustomFilterDefinition) {
		reportCustomFilterDefinitionDao.save(reportCustomFilterDefinition);
	}
}
