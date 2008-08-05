package com.mpower.domain;

import java.util.SortedSet;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Sort;
import org.hibernate.annotations.SortType;

@Entity
public class ReportFieldGroup implements java.io.Serializable,
		Comparable<ReportFieldGroup> {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	private String Name;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@Sort(type = SortType.NATURAL)
	private SortedSet<ReportField> fields;

	public void setName(String n) {
		Name = n;
	}

	public String getName() {
		return Name;
	}

	public void setFields(SortedSet<ReportField> f) {
		fields = f;
	}

	public SortedSet<ReportField> getFields() {

		return fields;
	}

	@Override
	public int compareTo(ReportFieldGroup o) {
		if (this.id > o.id)
			return 1;
		if (this.id < o.id)
			return -1;

		return 0;
	}
}