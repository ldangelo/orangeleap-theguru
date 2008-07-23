package com.mpower.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mpower.service.ReportSourceService;
import com.mpower.dao.ReportDataSourceDao;
import com.mpower.domain.ReportDataSource;

@Service("reportSourceService")
public class ReportSourceImpl implements ReportSourceService {
	@Resource(name = "reportDataSourceDao")
	private ReportDataSourceDao reportSourceDAO;
	
	@Override
	public List<ReportDataSource> readSources()
	{
		return reportSourceDAO.getAll();
	}
	
	@Override
	public void save(ReportDataSource datasource) 
	{
		reportSourceDAO.save(datasource);
	}

	@Override
	public ReportDataSource find(Long Id)
	{
		return reportSourceDAO.findById(Id);
	}
}
