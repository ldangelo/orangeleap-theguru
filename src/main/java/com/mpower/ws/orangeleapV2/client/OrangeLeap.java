package com.mpower.ws.orangeleapV2.client;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.bind.annotation.XmlSeeAlso;

/**
 * This class was generated by Apache CXF 2.2.4
 * Thu Jul 01 13:12:06 CDT 2010
 * Generated source version: 2.2.4
 * 
 */
 
@WebService(targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", name = "OrangeLeap")
@XmlSeeAlso({ObjectFactory.class})
@SOAPBinding(parameterStyle = SOAPBinding.ParameterStyle.BARE)
public interface OrangeLeap {

    @WebResult(name = "GetPickListsResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetPickListsResponse")
    @WebMethod(operationName = "GetPickLists")
    public GetPickListsResponse getPickLists(
        @WebParam(partName = "GetPickListsRequest", name = "GetPickListsRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetPickListsRequest getPickListsRequest
    );

    @WebResult(name = "GetConstituentRecurringGiftCountResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentRecurringGiftCountResponse")
    @WebMethod(operationName = "GetConstituentRecurringGiftCount")
    public GetConstituentRecurringGiftCountResponse getConstituentRecurringGiftCount(
        @WebParam(partName = "GetConstituentRecurringGiftCountRequest", name = "GetConstituentRecurringGiftCountRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentRecurringGiftCountRequest getConstituentRecurringGiftCountRequest
    );

    @WebResult(name = "GetConstituentGiftCountResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentGiftCountResponse")
    @WebMethod(operationName = "GetConstituentGiftCount")
    public GetConstituentGiftCountResponse getConstituentGiftCount(
        @WebParam(partName = "GetConstituentGiftCountRequest", name = "GetConstituentGiftCountRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentGiftCountRequest getConstituentGiftCountRequest
    );

    @WebResult(name = "GetConstituentByListIdResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentByListIdResponse")
    @WebMethod(operationName = "GetConstituentByListId")
    public GetConstituentByListIdResponse getConstituentByListId(
        @WebParam(partName = "GetConstituentByListIdRequest", name = "GetConstituentByListIdRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentByListIdRequest getConstituentByListIdRequest
    );

    @WebResult(name = "GetConstituentPledgeResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentPledgeResponse")
    @WebMethod(operationName = "GetConstituentPledge")
    public GetConstituentPledgeResponse getConstituentPledge(
        @WebParam(partName = "GetConstituentPledgeRequest", name = "GetConstituentPledgeRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentPledgeRequest getConstituentPledgeRequest
    );

    @WebResult(name = "SaveOrUpdateGiftResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "SaveOrUpdateGiftResponse")
    @WebMethod(operationName = "SaveOrUpdateGift")
    public SaveOrUpdateGiftResponse saveOrUpdateGift(
        @WebParam(partName = "SaveOrUpdateGiftRequest", name = "SaveOrUpdateGiftRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        SaveOrUpdateGiftRequest saveOrUpdateGiftRequest
    );

    @WebResult(name = "GetSegmentationListResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetSegmentationListResponse")
    @WebMethod(operationName = "GetSegmentationList")
    public GetSegmentationListResponse getSegmentationList(
        @WebParam(partName = "GetSegmentationListRequest", name = "GetSegmentationListRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetSegmentationListRequest getSegmentationListRequest
    );

    @WebResult(name = "GetSegmentationByIdResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetSegmentationByIdResponse")
    @WebMethod(operationName = "GetSegmentationById")
    public GetSegmentationByIdResponse getSegmentationById(
        @WebParam(partName = "GetSegmentationByIdRequest", name = "GetSegmentationByIdRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetSegmentationByIdRequest getSegmentationByIdRequest
    );

    @WebResult(name = "GetSegmentationListCountResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetSegmentationListCountResponse")
    @WebMethod(operationName = "GetSegmentationListCount")
    public GetSegmentationListCountResponse getSegmentationListCount(
        @WebParam(partName = "GetSegmentationListCountRequest", name = "GetSegmentationListCountRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetSegmentationListCountRequest getSegmentationListCountRequest
    );

    @WebResult(name = "GetPickListByNameResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetPickListByNameResponse")
    @WebMethod(operationName = "GetPickListByName")
    public GetPickListByNameResponse getPickListByName(
        @WebParam(partName = "GetPickListByNameRequest", name = "GetPickListByNameRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetPickListByNameRequest getPickListByNameRequest
    );

    @WebResult(name = "SearchConstituentsResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "SearchConstituentsResponse")
    @WebMethod(operationName = "SearchConstituents")
    public SearchConstituentsResponse searchConstituents(
        @WebParam(partName = "SearchConstituentsRequest", name = "SearchConstituentsRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        SearchConstituentsRequest searchConstituentsRequest
    );

    @WebResult(name = "AddPickListItemByNameResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "AddPickListItemByNameResponse")
    @WebMethod(operationName = "AddPickListItemByName")
    public AddPickListItemByNameResponse addPickListItemByName(
        @WebParam(partName = "AddPickListItemByNameRequest", name = "AddPickListItemByNameRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        AddPickListItemByNameRequest addPickListItemByNameRequest
    );

    @WebResult(name = "GetConstituentRecurringGiftResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentRecurringGiftResponse")
    @WebMethod(operationName = "GetConstituentRecurringGift")
    public GetConstituentRecurringGiftResponse getConstituentRecurringGift(
        @WebParam(partName = "GetConstituentRecurringGiftRequest", name = "GetConstituentRecurringGiftRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentRecurringGiftRequest getConstituentRecurringGiftRequest
    );

    @WebResult(name = "CreateDefaultConstituentResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "CreateDefaultConstituentResponse")
    @WebMethod(operationName = "CreateDefaultConstituent")
    public CreateDefaultConstituentResponse createDefaultConstituent(
        @WebParam(partName = "CreateDefaultConstituentRequest", name = "CreateDefaultConstituentRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        CreateDefaultConstituentRequest createDefaultConstituentRequest
    );

    @WebResult(name = "GetConstituentByIdResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentByIdResponse")
    @WebMethod(operationName = "GetConstituentById")
    public GetConstituentByIdResponse getConstituentById(
        @WebParam(partName = "GetConstituentByIdRequest", name = "GetConstituentByIdRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentByIdRequest getConstituentByIdRequest
    );

    @WebResult(name = "GetSegmentationListByTypeCountResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetSegmentationListByTypeCountResponse")
    @WebMethod(operationName = "GetSegmentationListByTypeCount")
    public GetSegmentationListByTypeCountResponse getSegmentationListByTypeCount(
        @WebParam(partName = "GetSegmentationListByTypeCountRequest", name = "GetSegmentationListByTypeCountRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetSegmentationListByTypeCountRequest getSegmentationListByTypeCountRequest
    );

    @WebResult(name = "GetPaymentSourcesByConstituentIdResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetPaymentSourcesByConstituentIdResponse")
    @WebMethod(operationName = "GetPaymentSourcesByConstituentId")
    public GetPaymentSourcesByConstituentIdResponse getPaymentSourcesByConstituentId(
        @WebParam(partName = "GetPaymentSourcesByConstituentIdRequest", name = "GetPaymentSourcesByConstituentIdRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetPaymentSourcesByConstituentIdRequest getPaymentSourcesByConstituentIdRequest
    );

    @WebResult(name = "GetConstituentPledgeCountResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentPledgeCountResponse")
    @WebMethod(operationName = "GetConstituentPledgeCount")
    public GetConstituentPledgeCountResponse getConstituentPledgeCount(
        @WebParam(partName = "GetConstituentPledgeCountRequest", name = "GetConstituentPledgeCountRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentPledgeCountRequest getConstituentPledgeCountRequest
    );

    @WebResult(name = "SaveOrUpdateConstituentResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "SaveOrUpdateConstituentResponse")
    @WebMethod(operationName = "SaveOrUpdateConstituent")
    public SaveOrUpdateConstituentResponse saveOrUpdateConstituent(
        @WebParam(partName = "SaveOrUpdateConstituentRequest", name = "SaveOrUpdateConstituentRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        SaveOrUpdateConstituentRequest saveOrUpdateConstituentRequest
    );

    @WebResult(name = "GetConstituentGiftResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentGiftResponse")
    @WebMethod(operationName = "GetConstituentGift")
    public GetConstituentGiftResponse getConstituentGift(
        @WebParam(partName = "GetConstituentGiftRequest", name = "GetConstituentGiftRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentGiftRequest getConstituentGiftRequest
    );

    @WebResult(name = "FindConstituentsResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "FindConstituentsResponse")
    @WebMethod(operationName = "FindConstituents")
    public FindConstituentsResponse findConstituents(
        @WebParam(partName = "FindConstituentsRequest", name = "FindConstituentsRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        FindConstituentsRequest findConstituentsRequest
    );

    @WebResult(name = "AddCommunicationHistoryResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "AddCommunicationHistoryResponse")
    @WebMethod(operationName = "AddCommunicationHistory")
    public AddCommunicationHistoryResponse addCommunicationHistory(
        @WebParam(partName = "AddCommunicationHistoryRequest", name = "AddCommunicationHistoryRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        AddCommunicationHistoryRequest addCommunicationHistoryRequest
    );

    @WebResult(name = "GetCommunicationHistoryResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetCommunicationHistoryResponse")
    @WebMethod(operationName = "GetCommunicationHistory")
    public GetCommunicationHistoryResponse getCommunicationHistory(
        @WebParam(partName = "GetCommunicationHistoryRequest", name = "GetCommunicationHistoryRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetCommunicationHistoryRequest getCommunicationHistoryRequest
    );

    @WebResult(name = "GetSegmentationListByTypeResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetSegmentationListByTypeResponse")
    @WebMethod(operationName = "GetSegmentationListByType")
    public GetSegmentationListByTypeResponse getSegmentationListByType(
        @WebParam(partName = "GetSegmentationListByTypeRequest", name = "GetSegmentationListByTypeRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetSegmentationListByTypeRequest getSegmentationListByTypeRequest
    );

    @WebResult(name = "SaveOrUpdateRecurringGiftResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "SaveOrUpdateRecurringGiftResponse")
    @WebMethod(operationName = "SaveOrUpdateRecurringGift")
    public SaveOrUpdateRecurringGiftResponse saveOrUpdateRecurringGift(
        @WebParam(partName = "SaveOrUpdateRecurringGiftRequest", name = "SaveOrUpdateRecurringGiftRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        SaveOrUpdateRecurringGiftRequest saveOrUpdateRecurringGiftRequest
    );

    @WebResult(name = "GetConstituentByPaymentSourceResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetConstituentByPaymentSourceResponse")
    @WebMethod(operationName = "GetConstituentByPaymentSource")
    public GetConstituentByPaymentSourceResponse getConstituentByPaymentSource(
        @WebParam(partName = "GetConstituentByPaymentSourceRequest", name = "GetConstituentByPaymentSourceRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetConstituentByPaymentSourceRequest getConstituentByPaymentSourceRequest
    );

    @WebResult(name = "BulkAddCommunicationHistoryResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "BulkAddCommunicationHistoryResponse")
    @WebMethod(operationName = "BulkAddCommunicationHistory")
    public BulkAddCommunicationHistoryResponse bulkAddCommunicationHistory(
        @WebParam(partName = "BulkAddCommunicationHistoryRequest", name = "BulkAddCommunicationHistoryRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        BulkAddCommunicationHistoryRequest bulkAddCommunicationHistoryRequest
    );

    @WebResult(name = "GetPickListsCountResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetPickListsCountResponse")
    @WebMethod(operationName = "GetPickListsCount")
    public GetPickListsCountResponse getPickListsCount(
        @WebParam(partName = "GetPickListsCountRequest", name = "GetPickListsCountRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetPickListsCountRequest getPickListsCountRequest
    );

    @WebResult(name = "GetSegmentationByNameResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetSegmentationByNameResponse")
    @WebMethod(operationName = "GetSegmentationByName")
    public GetSegmentationByNameResponse getSegmentationByName(
        @WebParam(partName = "GetSegmentationByNameRequest", name = "GetSegmentationByNameRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetSegmentationByNameRequest getSegmentationByNameRequest
    );

    @WebResult(name = "GetCommunicationHistoryCountResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "GetCommunicationHistoryCountResponse")
    @WebMethod(operationName = "GetCommunicationHistoryCount")
    public GetCommunicationHistoryCountResponse getCommunicationHistoryCount(
        @WebParam(partName = "GetCommunicationHistoryCountRequest", name = "GetCommunicationHistoryCountRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        GetCommunicationHistoryCountRequest getCommunicationHistoryCountRequest
    );

    @WebResult(name = "SaveOrUpdatePledgeResponse", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/", partName = "SaveOrUpdatePledgeResponse")
    @WebMethod(operationName = "SaveOrUpdatePledge")
    public SaveOrUpdatePledgeResponse saveOrUpdatePledge(
        @WebParam(partName = "SaveOrUpdatePledgeRequest", name = "SaveOrUpdatePledgeRequest", targetNamespace = "http://www.orangeleap.com/orangeleap/services2.0/")
        SaveOrUpdatePledgeRequest saveOrUpdatePledgeRequest
    );
}