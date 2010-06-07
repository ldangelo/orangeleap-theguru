package com.mpower.service;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportDataSourceDao;
import com.mpower.dao.ReportDataSubSourceDao;
import com.mpower.domain.ReportDataSubSource;

@Service("reportSubSourceService")
public class ReportSubSourceImpl implements ReportSubSourceService {
	@Resource(name = "reportDataSubSourceDao")
	private ReportDataSubSourceDao reportSubSourceDAO;


	public ReportDataSubSource find(Long Id) {

		return reportSubSourceDAO.findById(Id);
	}


	public List<ReportDataSubSource> readSubSourcesByReportSubSourceGroupId(Long l) {

		return reportSubSourceDAO.getAllByReportSubSourceGroupId(l);
	}


	public void save(ReportDataSubSource datasubsource) {
		
		reportSubSourceDAO.save(datasubsource);
	}

}
