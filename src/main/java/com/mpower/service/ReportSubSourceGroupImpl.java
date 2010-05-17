package com.mpower.service;

import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportDataSourceDao;
import com.mpower.dao.ReportDataSubSourceGroupDao;
import com.mpower.domain.ReportDataSubSourceGroup;

@Service("reportSubSourceGroupService")
public class ReportSubSourceGroupImpl implements ReportSubSourceGroupService {
	@Resource(name = "reportDataSubSourceGroupDao")
	private ReportDataSubSourceGroupDao reportSubSourceGroupDAO;


	public ReportDataSubSourceGroup find(Long Id) {

		return reportSubSourceGroupDAO.findById(Id);
	}


	public List<ReportDataSubSourceGroup> readSubSourceGroupsByReportSourceId(Long l) {

		return reportSubSourceGroupDAO.getAllByReportSourceId(l);
	}


	public void save(ReportDataSubSourceGroup dataSubSourceGroup) {
		
		reportSubSourceGroupDAO.save(dataSubSourceGroup);
	}

}
