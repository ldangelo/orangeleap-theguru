package com.mpower.service.customfiltercriterialookup;

import java.util.List;

import javax.annotation.Resource;

import com.mpower.domain.ReportCustomFilter;
import com.mpower.service.OrangeLeapService;

public class OrangeLeapPostalCodeRadius implements ReportCustomFilterCriteriaLookupService {

	@Resource(name = "orangeLeapService")
	private OrangeLeapService orangeLeapService;
	
	@Override
	public String getLookupSql(ReportCustomFilter filter) {
		String result = "";
		int radius = Integer.parseInt(filter.getReportCustomFilterCriteria().get(0).getCriteria());
		String postalCode = filter.getReportCustomFilterCriteria().get(1).getCriteria();
		String country = filter.getReportCustomFilterCriteria().get(2).getCriteria();
		List<String> postalCodes = orangeLeapService.getPostalCodesInRadius(country, postalCode, radius);
		boolean addComma = false; 
		for (String postalCodeInRadius : postalCodes) {
			if (addComma)
				result += ", ";
			else 
				addComma = true;
			result += "'" + postalCodeInRadius + "'";
		}
		return result;
		/*
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
		*/
	}
}
