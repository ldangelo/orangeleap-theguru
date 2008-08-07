package com.mpower.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportDataSourceDao;
import com.mpower.dao.ReportDataSubSourceDao;
import com.mpower.domain.ReportDataSubSource;

@Service("reportSubSourceService")
public class ReportSubSourceImpl implements ReportSubSourceService {
	@Resource(name = "reportDataSubSourceDao")
	private ReportDataSubSourceDao reportSubSourceDAO;

	@Override
	public ReportDataSubSource find(Long Id) {

		return reportSubSourceDAO.findById(Id);
	}

	@Override
	public List<ReportDataSubSource> readSubSourcesByReportSourceId(Long l) {

		return reportSubSourceDAO.getAllByReportSourceId(l);
	}

	@Override
	public void save(ReportDataSubSource datasubsource) {
		
		reportSubSourceDAO.save(datasubsource);
	}

}
