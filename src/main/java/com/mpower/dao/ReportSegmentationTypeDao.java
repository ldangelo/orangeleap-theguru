package com.mpower.dao;

import java.util.List;

import com.mpower.domain.ReportSegmentationType;

public interface ReportSegmentationTypeDao {
	public ReportSegmentationType findById(long Id);

	public List<ReportSegmentationType> getAll();
	public List<ReportSegmentationType> getAllByReportDataSubSourceId(Long id);
	public List<ReportSegmentationType> getAllBySegmentationTypeName(String segmentationTypeName);
	public void save(ReportSegmentationType reportSegmentationType);

	public ReportSegmentationType update(ReportSegmentationType reportSegmentationType);
	public ReportSegmentationType copy(ReportSegmentationType reportSegmentationType);

	public void delete(ReportSegmentationType reportSegmentationType);
}
