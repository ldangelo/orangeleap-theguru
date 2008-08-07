package com.mpower.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportDataSubSourceDao;
import com.mpower.dao.ReportFieldDao;
import com.mpower.dao.ReportFieldGroupDao;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;

@Service("reportFieldService")
public class ReportFieldServiceImpl implements ReportFieldService {
	@Resource(name = "reportFieldDao")
	private ReportFieldDao reportFieldDAO;

	@Override
	public ReportField find(Long Id) {
		
		return reportFieldDAO.findById(Id);
	}

	@Override
	public List<ReportField> readFieldByGroupId(Long l) {
		// TODO Auto-generated method stub
		return reportFieldDAO.getAllByGroupId(l);
	}

	@Override
	public void save(ReportField f) {
		reportFieldDAO.save(f);

	}

}
