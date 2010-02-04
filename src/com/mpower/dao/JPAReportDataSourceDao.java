package com.mpower.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.mpower.domain.ReportDataSource;

@Repository("reportDataSourceDao")
public class JPAReportDataSourceDao implements ReportDataSourceDao {
	@PersistenceContext
	private EntityManager em;

	public void save(ReportDataSource datasource) {
		em.merge(datasource);

	}

	public void delete(ReportDataSource datasource) {
		em.remove(datasource);

	}

	public ReportDataSource findById(long Id) {
		// TODO Auto-generated method stub
		return em.find(ReportDataSource.class, Id);
	}

	@SuppressWarnings("unchecked")
	public List<ReportDataSource> getAll() {
		Query q = em
				.createQuery("SELECT reportdatasource from com.mpower.domain.ReportDataSource reportdatasource order by reportdatasource.sortOrder, reportdatasource.Name");
		List<ReportDataSource> lrds = q.getResultList();
		List<ReportDataSource> ssrds = new LinkedList<ReportDataSource>();

		Iterator it = lrds.iterator();
		while (it.hasNext()) {
			ReportDataSource rds = (ReportDataSource) it.next();
			ssrds.add( rds);
		}
		return ssrds;

	}

	public ReportDataSource update(ReportDataSource datasource) {
		return em.merge(datasource);
	}

}
