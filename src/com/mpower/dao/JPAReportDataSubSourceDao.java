package com.mpower.dao;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;
import com.mpower.domain.ReportDataSubSource;

@Repository("reportDataSubSourceDao")
public class JPAReportDataSubSourceDao implements ReportDataSubSourceDao {
	@PersistenceContext
	private EntityManager em;
	

	public ReportDataSubSource copy(ReportDataSubSource datasubsource) {
		// TODO Auto-generated method stub
		return null;
	}


	public void delete(ReportDataSubSource datasubsource) {
		em.remove(datasubsource);

	}


	public ReportDataSubSource findById(long Id) {
		return em.find(ReportDataSubSource.class, Id);
	}

	@SuppressWarnings("unchecked")

	public List<ReportDataSubSource> getAll() {
		Query q = em
		.createQuery("SELECT reportdatasubsource from com.mpower.domain.ReportDataSubSource reportdatasubsource");
		List<ReportDataSubSource> lrds = q.getResultList();

		return lrds;
	}

	@SuppressWarnings("unchecked")

	public List<ReportDataSubSource> getAllByReportSourceId(Long id) {
		Query q = em
		.createQuery("select reportSubSource from ReportDataSubSource reportSubSource left join reportSubSource.reportDataSource as reportSource where reportSource.id = ?");
		q.setParameter(1, id);
		List<ReportDataSubSource> lrds = q.getResultList();
		
		return lrds;
	}


	public void save(ReportDataSubSource datasubsource) {
		em.merge(datasubsource);
	}

	public ReportDataSubSource update(ReportDataSubSource datasubsource) {
		em.merge(datasubsource);
		return null;
	}

}
