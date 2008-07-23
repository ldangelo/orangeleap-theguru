package com.mpower.dao;

import java.util.List;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.validator.GenericValidator;
import org.springframework.stereotype.Repository;
import com.mpower.domain.ReportDataSource;

@Repository("reportDataSourceDao")
public class JPAReportDataSourceDao implements ReportDataSourceDao {
	@PersistenceContext
	private EntityManager em;

	@Override
	public void save(ReportDataSource datasource) {
		em.persist(datasource);

	}

	@Override
	public void delete(ReportDataSource datasource) {
		em.remove(datasource);

	}

	@Override
	public ReportDataSource findById(long Id) {
		// TODO Auto-generated method stub
		return em.find(ReportDataSource.class, Id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ReportDataSource> getAll() {
		Query q = em.createQuery("SELECT reportdatasource from com.mpower.domain.ReportDataSource reportdatasource");
		return q.getResultList();

	}

	@Override
	public ReportDataSource update(ReportDataSource datasource) {
		return em.merge(datasource);
	}

}
