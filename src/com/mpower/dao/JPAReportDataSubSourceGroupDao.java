package com.mpower.dao;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;
import com.mpower.domain.ReportDataSubSourceGroup;

@Repository("reportDataSubSourceGroupDao")
public class JPAReportDataSubSourceGroupDao implements ReportDataSubSourceGroupDao {
	@PersistenceContext
	private EntityManager em;
	

	public ReportDataSubSourceGroup copy(ReportDataSubSourceGroup dataSubSourceGroup) {
		// TODO Auto-generated method stub
		return null;
	}


	public void delete(ReportDataSubSourceGroup dataSubSourceGroup) {
		em.remove(dataSubSourceGroup);

	}


	public ReportDataSubSourceGroup findById(long Id) {
		return em.find(ReportDataSubSourceGroup.class, Id);
	}

	@SuppressWarnings("unchecked")

	public List<ReportDataSubSourceGroup> getAll() {
		Query q = em
		.createQuery("SELECT reportdatasubsourcegroup from com.mpower.domain.ReportDataSubSourceGroup reportdatasubsourcegroup");
		List<ReportDataSubSourceGroup> lrds = q.getResultList();

		return lrds;
	}

	@SuppressWarnings("unchecked")

	public List<ReportDataSubSourceGroup> getAllByReportSourceId(Long id) {
		Query q = em
		.createQuery("select reportSubSourceGroup from ReportDataSubSourceGroup reportSubSourceGroup left join reportSubSourceGroup.reportDataSource as reportSource where reportSource.id = ?");
		q.setParameter(1, id);
		List<ReportDataSubSourceGroup> lrds = q.getResultList();
		
		return lrds;
	}


	public void save(ReportDataSubSourceGroup dataSubSourceGroup) {
		em.merge(dataSubSourceGroup);
	}

	public ReportDataSubSourceGroup update(ReportDataSubSourceGroup dataSubSourceGroup) {
		em.merge(dataSubSourceGroup);
		return null;
	}

}
