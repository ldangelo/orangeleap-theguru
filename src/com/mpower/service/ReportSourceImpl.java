package com.mpower.service;

import java.util.SortedSet;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportDataSourceDao;
import com.mpower.domain.ReportDataSource;

@Service("reportSourceService")
public class ReportSourceImpl implements ReportSourceService {
	@Resource(name = "reportDataSourceDao")
	private ReportDataSourceDao reportSourceDAO;

	@Override
	public SortedSet<ReportDataSource> readSources() {
		return reportSourceDAO.getAll();
	}

	@Override
	public void save(ReportDataSource datasource) {
		reportSourceDAO.save(datasource);
	}

	@Override
	public ReportDataSource find(Long Id) {
		return reportSourceDAO.findById(Id);
	}
}
