package com.mpower.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportDataSourceDao;
import com.mpower.domain.ReportDataSource;

@Service("reportSourceService")
public class ReportSourceImpl implements ReportSourceService {
	@Resource(name = "reportDataSourceDao")
	private ReportDataSourceDao reportSourceDAO;


	public List<ReportDataSource> readSources() {
		return reportSourceDAO.getAll();
	}


	public void save(ReportDataSource datasource) {
		reportSourceDAO.save(datasource);
	}


	public ReportDataSource find(Long Id) {
		return reportSourceDAO.findById(Id);
	}
}
