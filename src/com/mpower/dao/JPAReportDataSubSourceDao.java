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
	
	@Override
	public ReportDataSubSource copy(ReportDataSubSource datasubsource) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(ReportDataSubSource datasubsource) {
		em.remove(datasubsource);

	}

	@Override
	public ReportDataSubSource findById(long Id) {
		return em.find(ReportDataSubSource.class, Id);
	}

	@Override
	public List<ReportDataSubSource> getAll() {
		Query q = em
		.createQuery("SELECT reportdatasubsource from com.mpower.domain.ReportDataSubSource reportdatasubsource");
		List<ReportDataSubSource> lrds = q.getResultList();

		return lrds;
	}

	@Override
	public List<ReportDataSubSource> getAllByReportSourceId(Long id) {
		Query q = em
		.createQuery("SELECT reportdatasubsource from com.mpower.domain.ReportDataSubSource reportdatasubsource ");
		List<ReportDataSubSource> lrds = q.getResultList();
		List<ReportDataSubSource> ssrds = new LinkedList<ReportDataSubSource>();

		Iterator it = lrds.iterator();
		while (it.hasNext()) {
			ReportDataSubSource rds = (ReportDataSubSource) it.next();
			ssrds.add( rds);
		}
		return ssrds;
	}

	@Override
	public void save(ReportDataSubSource datasubsource) {
		em.persist(datasubsource);
	}

	@Override
	public ReportDataSubSource update(ReportDataSubSource datasubsource) {
		em.persist(datasubsource);
		return null;
	}

}
