package com.mpower.service;

import java.util.List;

import com.mpower.domain.ReportSegmentationResult;

public interface ReportSegmentationResultsService {
	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId) throws Exception;

	public int executeSegmentation(Long reportId) throws Exception;
}
