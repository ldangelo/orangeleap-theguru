package com.mpower.service;

import java.util.List;

import com.mpower.domain.ReportSegmentationType;

public interface ReportSegmentationTypeService {
	public List<ReportSegmentationType> readReportSegmentationTypeBySubSourceId(Long Id);

	public List<ReportSegmentationType> findReportSegmentationTypeBySegmentationTypeName(String segmentationTypeName);

	public void save(ReportSegmentationType reportSegmentationType);

	public ReportSegmentationType find(Long Id);

}
