package com.mpower.service.customfilterdefinitionlookup;

import java.util.List;

import com.mpower.domain.ReportSegmentationType;
import com.mpower.domain.ReportWizard;
import com.mpower.service.ReportSegmentationTypeService;
import com.mpower.service.ReportWizardService;

public class SegmentationList implements ReportCustomFilterDefinitionLookupService {

	private ReportWizardService reportWizardService;
	private ReportSegmentationTypeService reportSegmentationTypeService;
	private String segmentationType;

	@Override
	public String getLookupHtml(ReportWizard reportWizard, Integer criteriaIndex, String selectedValue) {
		if (criteriaIndex == null)
			criteriaIndex = 0;
		List<ReportWizard> segmentations = reportWizardService.findSegmentationsByReportDataSourceId(reportWizard.getSrcId());
		String result = "<select objectname=\"reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[" + criteriaIndex.toString() + "].criteria\" class=\"customCriteria\" >";
		List<ReportSegmentationType> segmentationTypes;
		if (segmentationType != null && segmentationType.length() == 0) {
			segmentationTypes = reportSegmentationTypeService.findReportSegmentationTypeBySegmentationTypeName(segmentationType);
		}
		for (ReportWizard segmentation : segmentations) {
			Boolean addSegmentation = false;
			if (segmentationType == null || segmentationType.length() == 0) {
				addSegmentation = true;
			}
			else {
				segmentationTypes = reportSegmentationTypeService.findReportSegmentationTypeBySegmentationTypeName(segmentationType);
				for (ReportSegmentationType reportSegmentationType : segmentationTypes) {
					if (segmentation.getReportSegmentationTypeId() == reportSegmentationType.getId()) {
						addSegmentation = true;
						break;
					}
				}
			}
			if (addSegmentation)
			{
				result += "<option value=\"" + segmentation.getId().toString() + "\"";
				if (selectedValue != null && selectedValue.length() > 0 && selectedValue.equals(segmentation.getId().toString()))
					result += " selected=\"true\"";
				result += " >ID " + segmentation.getId().toString() + " : " + segmentation.getReportName() + "</option>";
			}
		}
		result += "</select>";
		return result;
	}

	public void setReportWizardService(ReportWizardService reportWizardService) {
		this.reportWizardService = reportWizardService;
	}

	public ReportWizardService getReportWizardService() {
		return reportWizardService;
	}

	public void setReportSegmentationTypeService(
			ReportSegmentationTypeService reportSegmentationTypeService) {
		this.reportSegmentationTypeService = reportSegmentationTypeService;
	}

	public ReportSegmentationTypeService getReportSegmentationTypeService() {
		return reportSegmentationTypeService;
	}

	public void setSegmentationType(String segmentationType) {
		this.segmentationType = segmentationType;
	}

	public String getSegmentationType() {
		return segmentationType;
	}

}
