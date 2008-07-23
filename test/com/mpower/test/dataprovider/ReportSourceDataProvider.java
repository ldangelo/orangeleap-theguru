package com.mpower.test.dataprovider;

import java.util.LinkedList;
import org.testng.annotations.DataProvider;

import com.mpower.domain.ReportFieldType;
import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportAdvancedFilter;
import com.mpower.domain.ReportStandardFilter;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.domain.ReportField;

public class ReportSourceDataProvider {
	 @DataProvider(name = "setupCreateReportSource")
	 public static Object[][] setupCreateReportSource()
	 {
		 ReportDataSource rs = new ReportDataSource();
		 ReportDataSubSource rss = new ReportDataSubSource();
		
		 
		 rs.setName("People");
		 rss.setDisplayName("People");
		 rss.setViewName("vPeople");
		 rss.setAdvancedFilter(new ReportAdvancedFilter());
		 rss.setStandardFilter(new ReportStandardFilter());

		 ReportFieldGroup rfg = new ReportFieldGroup();

		 rfg.setName("Name");
		 LinkedList<ReportField> fields = new LinkedList<ReportField>();
		 
		 ReportField rf1 = new ReportField();
		 rf1.setDisplayName("First Name");
		 rf1.setColumnName("First_Name");
		 rf1.setFieldType(ReportFieldType.STRING);
		 rf1.setIsDefault(true);
		 rf1.setCanBeSummarized(false);
		 fields.add(rf1);

		 ReportField rf2 = new ReportField();
		 rf2.setDisplayName("Last Name");
		 rf2.setColumnName("Last_Name");
		 rf2.setFieldType(ReportFieldType.STRING);
		 rf2.setIsDefault(true);
		 rf2.setCanBeSummarized(false);
		 fields.add(rf2);
		 
		 rfg.setFields(fields);
		 
		 LinkedList<ReportFieldGroup> lrfg = new LinkedList<ReportFieldGroup>();
		 lrfg.add(rfg);
		 rss.setFieldGroups(lrfg);
		 
		 LinkedList<ReportDataSubSource> rssl = new LinkedList<ReportDataSubSource>();
		 rssl.add(rss);
		 rs.setSubSources(rssl);
		 
		 return new Object[][] { new Object[] { rs }};
	 }
}
