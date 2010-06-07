package com.mpower.service;

import java.util.List;

import com.mpower.domain.ReportSegmentationResult;

public interface ReportSegmentationResultsService {
	public List<ReportSegmentationResult> readReportSegmentationResultsByReportId(Long reportId, String username, String password) throws Exception;

	public int executeSegmentation(Long reportId, String username, String password) throws Exception;
}
