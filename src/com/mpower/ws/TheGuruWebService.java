package com.mpower.ws;

import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mpower.ws.axis.GetSegmentationByNameRequest;
import com.mpower.ws.axis.GetSegmentationByNameResponse;
import com.mpower.ws.axis.GetSegmentationListRequest;
import com.mpower.ws.axis.GetSegmentationListResponse;
import com.mpower.ws.axis.ObjectFactory;
import com.mpower.ws.axis.Segmentation;

@Endpoint
public class TheGuruWebService {
	
    private static final Log logger = LogFactory.getLog(TheGuruWebService.class);

    @PayloadRoot(localPart = "GetSegmentationListRequest", namespace = "http://www.orangeleap.com/theguru/services/1.0")
    public GetSegmentationListResponse getSegmentationList(GetSegmentationListRequest request) {
    	ObjectFactory of = new ObjectFactory();
    	
    	GetSegmentationListResponse response = of.createGetSegmentationListResponse();
    	Segmentation seg = of.createSegmentation();
    	
    	seg.setId(0);
    	seg.setName("Test");
    	seg.setDescription("Testing");
    	response.getSegmentation().add(seg);
    	
        return response;
    }

        @PayloadRoot(localPart = "GetSegmentationByNameRequest", namespace = "http://www.orangeleap.com/theguru/services/1.0")
        public GetSegmentationByNameResponse getSegmentationByName(GetSegmentationByNameRequest request) {
        	return null;
        }
    
}
