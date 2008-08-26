package com.mpower.test.dataprovider;

import java.util.ArrayList;
import java.util.HashMap;

import org.testng.annotations.DataProvider;

import com.mpower.domain.ReportDataSource;
import com.mpower.domain.ReportDataSubSource;
import com.mpower.domain.ReportField;
import com.mpower.domain.ReportFieldGroup;
import com.mpower.domain.ReportFieldType;

public class ReportSourceDataProvider {
	@SuppressWarnings("unchecked")
	@DataProvider(name = "setupCreateReportSource")
	public static Object[][] setupCreateReportSource() {
		ReportDataSource               rs   = new ReportDataSource();
		ReportDataSubSource            rss  = new ReportDataSubSource();
		ArrayList<ReportDataSubSource> lrss = new ArrayList<ReportDataSubSource>();
		
		rs.setName("People");
		rss.setDisplayName("People");
		rss.setViewName("vPeople");
		
		rss.setReportDataSource(rs);
		lrss.add(rss);
		
		rs.setSubSource(lrss);
		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");


		ReportField rf1 = new ReportField();

		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setSelected(true);
		rf1.setCanBeSummarized(false);
		ArrayList<ReportFieldGroup> lrfg = new ArrayList<ReportFieldGroup>();
		lrfg.add(rfg);
		rf1.setReportFieldGroup(new ArrayList<ReportFieldGroup>());
		
		ReportField rf2 = new ReportField();
		rf2.setDisplayName("Last Name");
		rf2.setColumnName("Last_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setSelected(true);
		rf2.setCanBeSummarized(false);
		rf2.setReportFieldGroup(lrfg);
		ArrayList<ReportField> fields = new ArrayList<ReportField>();
		fields.add(rf1);
		fields.add(rf2);
		rfg.setFields(fields);
		
		rfg.setReportDataSubSource(lrss);
		rss.setReportDataSource(rs);

		return new Object[][] { new Object[] { rs } };
	}
	
	@SuppressWarnings("unchecked")
	@DataProvider(name = "setupCreateReportSubSource")
	public static Object[][] setupCreateReportSubSource() {
		ReportDataSource rs = new ReportDataSource();
		ReportDataSubSource rss = new ReportDataSubSource();

		rs.setName("People");
		rss.setDisplayName("People");
		rss.setViewName("vPeople");

		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");

		ReportField rf1 = new ReportField();

		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setSelected(true);
		rf1.setCanBeSummarized(false);
		ArrayList<ReportFieldGroup> lrfg = new ArrayList<ReportFieldGroup>();
		lrfg.add(rfg);
		rf1.setReportFieldGroup(lrfg);
		
		ReportField rf2 = new ReportField();
		rf2.setDisplayName("Last Name");
		rf2.setColumnName("Last_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setSelected(true);
		rf2.setCanBeSummarized(false);
		rf2.setReportFieldGroup(lrfg);
		ArrayList<ReportDataSubSource> lrss = new ArrayList<ReportDataSubSource>();
		lrss.add(rss);
		
		ArrayList<ReportField> fields = new ArrayList<ReportField>();
		fields.add(rf1);
		fields.add(rf2);
		rfg.setFields(fields);
	
		rfg.setReportDataSubSource(lrss);
		rss.setReportDataSource(rs);

		return new Object[][] { new Object[] { rs, rss } };
	}
	
	@DataProvider(name = "setupReportFieldGroup")
	public static Object[][] setupFieldGroup() {
		ReportDataSource rs = new ReportDataSource();
		ReportDataSubSource rss = new ReportDataSubSource();

		rs.setName("People");
		rss.setDisplayName("People");
		rss.setViewName("vPeople");

		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");

		ReportField rf1 = new ReportField();

		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setSelected(true);
		rf1.setCanBeSummarized(false);
		ArrayList<ReportFieldGroup> lrfg = new ArrayList<ReportFieldGroup>();
		lrfg.add(rfg);
		rf1.setReportFieldGroup(lrfg);
		
		ReportField rf2 = new ReportField();
		rf2.setDisplayName("Last Name");
		rf2.setColumnName("Last_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setSelected(true);
		rf2.setCanBeSummarized(false);
		rf2.setReportFieldGroup(lrfg);

		ArrayList<ReportDataSubSource> lrss = new ArrayList<ReportDataSubSource>();
		lrss.add(rss);

		ArrayList<ReportField> fields = new ArrayList<ReportField>();
		fields.add(rf1);
		fields.add(rf2);
		rfg.setFields(fields);
	
		rfg.setReportDataSubSource(lrss);
		rss.setReportDataSource(rs);

		rs.setSubSource(lrss);
		
		return new Object[][] { new Object[] { rs, rss, rfg } };
	}
	
	@DataProvider(name = "setupReportField")
	public static Object[][] setupField() {
		ReportDataSource rs = new ReportDataSource();
		ReportDataSubSource rss = new ReportDataSubSource();

		rs.setName("People");
		rss.setDisplayName("People");
		rss.setViewName("vPeople");

		ReportFieldGroup rfg = new ReportFieldGroup();

		rfg.setName("Name");

		ReportField rf1 = new ReportField();

		rf1.setDisplayName("First Name");
		rf1.setColumnName("First_Name");
		rf1.setFieldType(ReportFieldType.STRING);
		rf1.setSelected(true);
		rf1.setCanBeSummarized(false);
		ArrayList<ReportFieldGroup> lrfg = new ArrayList<ReportFieldGroup>();
		lrfg.add(rfg);

		rf1.setReportFieldGroup(lrfg);
		
		ReportField rf2 = new ReportField();
		rf2.setDisplayName("Last Name");
		rf2.setColumnName("Last_Name");
		rf2.setFieldType(ReportFieldType.STRING);
		rf2.setSelected(true);
		rf2.setCanBeSummarized(false);
		rf2.setReportFieldGroup(lrfg);

		ArrayList<ReportDataSubSource> lrss = new ArrayList<ReportDataSubSource>();
		lrss.add(rss);

		ArrayList<ReportField> fields = new ArrayList<ReportField>();
		fields.add(rf1);
		fields.add(rf2);
		rfg.setFields(fields);
	
		rfg.setReportDataSubSource(lrss);
		rss.setReportDataSource(rs);

		return new Object[][] { new Object[] { rs, rss, rfg, rf1 } };
	}
	
}
