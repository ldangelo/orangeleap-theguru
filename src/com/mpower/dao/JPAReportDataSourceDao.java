package com.mpower.dao;

import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

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
	public SortedSet<ReportDataSource> getAll() {
		Query q = em
				.createQuery("SELECT reportdatasource from com.mpower.domain.ReportDataSource reportdatasource");
		List<ReportDataSource> lrds = q.getResultList();
		TreeSet<ReportDataSource> ssrds = new TreeSet<ReportDataSource>();

		ssrds.addAll(lrds);
		return ssrds;

	}

	@Override
	public ReportDataSource update(ReportDataSource datasource) {
		return em.merge(datasource);
	}

}
