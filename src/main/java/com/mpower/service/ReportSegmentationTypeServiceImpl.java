package com.mpower.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.mpower.dao.ReportSegmentationTypeDao;
import com.mpower.domain.ReportSegmentationType;

@Service("reportSegmentationTypeService")
public class ReportSegmentationTypeServiceImpl implements ReportSegmentationTypeService {
	@Resource(name = "reportSegmentationTypeDao")
	private ReportSegmentationTypeDao reportSegmentationTypeDao;

	public ReportSegmentationType find(Long Id) {
		return reportSegmentationTypeDao.findById(Id);
	}

	public List<ReportSegmentationType> findReportSegmentationTypeBySegmentationTypeName(String segmentationTypeName) {
		return reportSegmentationTypeDao.getAllBySegmentationTypeName(segmentationTypeName);
	}

	public List<ReportSegmentationType> readReportSegmentationTypeBySubSourceId(Long l) {
		return reportSegmentationTypeDao.getAllByReportDataSubSourceId(l);
	}

	public void save(ReportSegmentationType reportSegmentationType) {
		reportSegmentationTypeDao.save(reportSegmentationType);
	}
}
