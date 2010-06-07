package com.mpower.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportDataSubSourceDao;
import com.mpower.dao.ReportFieldGroupDao;
import com.mpower.domain.ReportFieldGroup;

@Service("reportFieldGroupService")
public class ReportFieldGroupServiceImpl implements ReportFieldGroupService {
	@Resource(name = "reportFieldGroupDao")
	private ReportFieldGroupDao reportFieldGroupDAO;


	public ReportFieldGroup find(Long Id) {
		
		return reportFieldGroupDAO.findById(Id);
	}


	public List<ReportFieldGroup> readFieldGroupBySubSourceId(Long l) {
		// TODO Auto-generated method stub
		return reportFieldGroupDAO.getAllByReportDataSubSourceId(l);
	}


	public void save(ReportFieldGroup group) {
		reportFieldGroupDAO.save(group);

	}

}
