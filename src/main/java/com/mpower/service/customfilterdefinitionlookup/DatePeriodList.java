package com.mpower.service.customfilterdefinitionlookup;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.mpower.domain.ReportWizard;

@Component("datePeriodList")
public class DatePeriodList implements ReportCustomFilterDefinitionLookupService {

	private class DatePeriod {
		private String label;
		private String criteria;
		
		public DatePeriod(String label, String criteria) {
			this.label = label;
			this.criteria = criteria;
		}
	}

	@Override
	public String getLookupHtml(ReportWizard reportWizard, Integer criteriaIndex, String selectedValue) {
		if (criteriaIndex == null)
			criteriaIndex = 0;
		
		String result = "<select class=\"customCriteria\" objectname=\"reportFilters[INDEXREPLACEMENT].reportCustomFilter.reportCustomFilterCriteria[" + criteriaIndex.toString() + "].criteria\" >";
		
		List<DatePeriod> datePeriods = new ArrayList<DatePeriod>();
		datePeriods.add(new DatePeriod("Current Calendar Year", "AND (( YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL 0 YEAR)) ))"));
		datePeriods.add(new DatePeriod("Previous Calendar Year", "AND (( YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL -1 YEAR)) ))"));
		datePeriods.add(new DatePeriod("Current and Previous Calendar Year", "AND (( ( YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL -1 YEAR)) ) OR ( YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL 0 YEAR)) ) ))"));
		datePeriods.add(new DatePeriod("Current Calendar Month", "AND (( MONTH(DONATION_DATE) = MONTH(DATE_ADD(CURDATE(), INTERVAL 0 MONTH)) AND YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL 0 MONTH)) ))"));
		datePeriods.add(new DatePeriod("Previous Calendar Month", "AND (( MONTH(DONATION_DATE) = MONTH(DATE_ADD(CURDATE(), INTERVAL -1 MONTH)) AND YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL -1 MONTH)) ))"));
		datePeriods.add(new DatePeriod("Current and Previous Calendar Month", "AND (( ( MONTH(DONATION_DATE) = MONTH(DATE_ADD(CURDATE(), INTERVAL -1 MONTH)) AND YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL -1 MONTH)) ) OR ( MONTH(DONATION_DATE) = MONTH(DATE_ADD(CURDATE(), INTERVAL 0 MONTH)) AND YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL 0 MONTH)) ) ))"));
		datePeriods.add(new DatePeriod("Current Calendar Week", "AND (( WEEK(DONATION_DATE) = WEEK(DATE_ADD(CURDATE(), INTERVAL 0 WEEK)) AND YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL 0 WEEK)) ))"));
		datePeriods.add(new DatePeriod("Previous Calendar Week", "AND (( WEEK(DONATION_DATE) = WEEK(DATE_ADD(CURDATE(), INTERVAL -1 WEEK)) AND YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL -1 WEEK)) ))"));
		datePeriods.add(new DatePeriod("Current and Previous Calendar Week", "AND (( ( WEEK(DONATION_DATE) = WEEK(DATE_ADD(CURDATE(), INTERVAL -1 WEEK)) AND YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL -1 WEEK)) ) OR ( WEEK(DONATION_DATE) = WEEK(DATE_ADD(CURDATE(), INTERVAL 0 WEEK)) AND YEAR(DONATION_DATE) = YEAR(DATE_ADD(CURDATE(), INTERVAL 0 WEEK)) ) ))"));
		datePeriods.add(new DatePeriod("Current Calendar Day", "AND (CAST(DONATION_DATE AS DATE) = DATE_ADD(CURDATE(),INTERVAL 0 DAY))"));
		datePeriods.add(new DatePeriod("Previous Calendar Day", "AND (CAST(DONATION_DATE AS DATE) = DATE_ADD(CURDATE(),INTERVAL -1 DAY))"));
		datePeriods.add(new DatePeriod("Last 7 Calendar Days", "AND (CAST(DONATION_DATE AS DATE) > DATE_ADD(CURDATE(),INTERVAL -7 DAY) AND CAST(DONATION_DATE AS DATE) <= DATE_ADD(CURDATE(),INTERVAL 0 DAY))"));
		datePeriods.add(new DatePeriod("Last 30 Calendar Days", "AND (CAST(DONATION_DATE AS DATE) > DATE_ADD(CURDATE(),INTERVAL -30 DAY)) AND CAST(DONATION_DATE AS DATE) <= DATE_ADD(CURDATE(),INTERVAL 0 DAY))"));
		datePeriods.add(new DatePeriod("Last 60 Calendar Days", "AND (CAST(DONATION_DATE AS DATE) > DATE_ADD(CURDATE(),INTERVAL -60 DAY)) AND CAST(DONATION_DATE AS DATE) <= DATE_ADD(CURDATE(),INTERVAL 0 DAY))"));
		datePeriods.add(new DatePeriod("Last 90 Calendar Days", "AND (CAST(DONATION_DATE AS DATE) > DATE_ADD(CURDATE(),INTERVAL -90 DAY)) AND CAST(DONATION_DATE AS DATE) <= DATE_ADD(CURDATE(),INTERVAL 0 DAY))"));
		datePeriods.add(new DatePeriod("Last 120 Calendar Days", "AND (CAST(DONATION_DATE AS DATE) > DATE_ADD(CURDATE(),INTERVAL -120 DAY)) AND CAST(DONATION_DATE AS DATE) <= DATE_ADD(CURDATE(),INTERVAL 0 DAY))"));	
		
		for (DatePeriod datePeriod : datePeriods) {
			result += "<option value=\"" + datePeriod.criteria + "\"";
			if (selectedValue != null && selectedValue.length() > 0 && selectedValue.equals(datePeriod.criteria))
				result += " selected=\"true\"";
			result += " >" + datePeriod.label + "</option>";
		}
		
		result += "</select>";
		return result;
	}
}
