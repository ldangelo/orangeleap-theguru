
package com.mpower.ws.orangeleapV3.client;

/**
 * Please modify this class to meet your needs
 * This class is not complete
 */

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import javax.xml.namespace.QName;
import javax.jws.Oneway;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.xml.bind.annotation.XmlSeeAlso;

/**
 * This class was generated by Apache CXF 2.2.4
 * Thu Jul 08 13:32:47 CDT 2010
 * Generated source version: 2.2.4
 * 
 */

public final class OrangeLeap_OrangeLeapSoap11_Client {

    private static final QName SERVICE_NAME = new QName("http://www.orangeleap.com/orangeleap/services3.0/", "OrangeLeapService");

    private OrangeLeap_OrangeLeapSoap11_Client() {
    }

    public static void main(String args[]) throws Exception {
        URL wsdlURL = OrangeLeapService.WSDL_LOCATION;
        if (args.length > 0) { 
            File wsdlFile = new File(args[0]);
            try {
                if (wsdlFile.exists()) {
                    wsdlURL = wsdlFile.toURI().toURL();
                } else {
                    wsdlURL = new URL(args[0]);
                }
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
        }
      
        OrangeLeapService ss = new OrangeLeapService(wsdlURL, SERVICE_NAME);
        OrangeLeap port = ss.getOrangeLeapSoap11();  
        
        {
        System.out.println("Invoking listCustomTableFields...");
        com.mpower.ws.orangeleapV3.client.ListCustomTableFieldsRequest _listCustomTableFields_listCustomTableFieldsRequest = null;
        com.mpower.ws.orangeleapV3.client.ListCustomTableFieldsResponse _listCustomTableFields__return = port.listCustomTableFields(_listCustomTableFields_listCustomTableFieldsRequest);
        System.out.println("listCustomTableFields.result=" + _listCustomTableFields__return);


        }
        {
        System.out.println("Invoking getCustomTableRows...");
        com.mpower.ws.orangeleapV3.client.GetCustomTableRowsRequest _getCustomTableRows_getCustomTableRowsRequest = null;
        com.mpower.ws.orangeleapV3.client.GetCustomTableRowsResponse _getCustomTableRows__return = port.getCustomTableRows(_getCustomTableRows_getCustomTableRowsRequest);
        System.out.println("getCustomTableRows.result=" + _getCustomTableRows__return);


        }
        {
        System.out.println("Invoking getCustomTableRowCount...");
        com.mpower.ws.orangeleapV3.client.GetCustomTableRowCountRequest _getCustomTableRowCount_getCustomTableRowCountRequest = null;
        com.mpower.ws.orangeleapV3.client.GetCustomTableRowCountResponse _getCustomTableRowCount__return = port.getCustomTableRowCount(_getCustomTableRowCount_getCustomTableRowCountRequest);
        System.out.println("getCustomTableRowCount.result=" + _getCustomTableRowCount__return);


        }
        {
        System.out.println("Invoking getCustomTableTitleField...");
        com.mpower.ws.orangeleapV3.client.GetCustomTableTitleFieldRequest _getCustomTableTitleField_getCustomTableTitleFieldRequest = null;
        com.mpower.ws.orangeleapV3.client.GetCustomTableTitleFieldResponse _getCustomTableTitleField__return = port.getCustomTableTitleField(_getCustomTableTitleField_getCustomTableTitleFieldRequest);
        System.out.println("getCustomTableTitleField.result=" + _getCustomTableTitleField__return);


        }
        {
        System.out.println("Invoking getCustomTableConstituentContextField...");
        com.mpower.ws.orangeleapV3.client.GetCustomTableConstituentContextFieldRequest _getCustomTableConstituentContextField_getCustomTableConstituentContextFieldRequest = null;
        com.mpower.ws.orangeleapV3.client.GetCustomTableConstituentContextFieldResponse _getCustomTableConstituentContextField__return = port.getCustomTableConstituentContextField(_getCustomTableConstituentContextField_getCustomTableConstituentContextFieldRequest);
        System.out.println("getCustomTableConstituentContextField.result=" + _getCustomTableConstituentContextField__return);


        }
        {
        System.out.println("Invoking readCustomTableRow...");
        com.mpower.ws.orangeleapV3.client.ReadCustomTableRowRequest _readCustomTableRow_readCustomTableRowRequest = null;
        com.mpower.ws.orangeleapV3.client.ReadCustomTableRowResponse _readCustomTableRow__return = port.readCustomTableRow(_readCustomTableRow_readCustomTableRowRequest);
        System.out.println("readCustomTableRow.result=" + _readCustomTableRow__return);


        }
        {
        System.out.println("Invoking getListMasterCustomTables...");
        com.mpower.ws.orangeleapV3.client.GetListMasterCustomTablesRequest _getListMasterCustomTables_getListMasterCustomTablesRequest = null;
        com.mpower.ws.orangeleapV3.client.GetListMasterCustomTablesResponse _getListMasterCustomTables__return = port.getListMasterCustomTables(_getListMasterCustomTables_getListMasterCustomTablesRequest);
        System.out.println("getListMasterCustomTables.result=" + _getListMasterCustomTables__return);


        }
        {
        System.out.println("Invoking getListDetailCustomTables...");
        com.mpower.ws.orangeleapV3.client.GetListDetailCustomTablesRequest _getListDetailCustomTables_getListDetailCustomTablesRequest = null;
        com.mpower.ws.orangeleapV3.client.GetListDetailCustomTablesResponse _getListDetailCustomTables__return = port.getListDetailCustomTables(_getListDetailCustomTables_getListDetailCustomTablesRequest);
        System.out.println("getListDetailCustomTables.result=" + _getListDetailCustomTables__return);


        }
        {
        System.out.println("Invoking readCustomTableById...");
        com.mpower.ws.orangeleapV3.client.ReadCustomTableByIdRequest _readCustomTableById_readCustomTableByIdRequest = null;
        com.mpower.ws.orangeleapV3.client.ReadCustomTableByIdResponse _readCustomTableById__return = port.readCustomTableById(_readCustomTableById_readCustomTableByIdRequest);
        System.out.println("readCustomTableById.result=" + _readCustomTableById__return);


        }
        {
        System.out.println("Invoking listCustomTables...");
        com.mpower.ws.orangeleapV3.client.ListCustomTablesRequest _listCustomTables_listCustomTablesRequest = null;
        com.mpower.ws.orangeleapV3.client.ListCustomTablesResponse _listCustomTables__return = port.listCustomTables(_listCustomTables_listCustomTablesRequest);
        System.out.println("listCustomTables.result=" + _listCustomTables__return);


        }
        {
        System.out.println("Invoking getListEntityeRelatedCustomTables...");
        com.mpower.ws.orangeleapV3.client.GetListEntityeRelatedCustomTablesRequest _getListEntityeRelatedCustomTables_getListEntityeRelatedCustomTablesRequest = null;
        port.getListEntityeRelatedCustomTables(_getListEntityeRelatedCustomTables_getListEntityeRelatedCustomTablesRequest);


        }
        {
        System.out.println("Invoking getPostalCodesByRadius...");
        com.mpower.ws.orangeleapV3.client.GetPostalCodesByRadiusRequest _getPostalCodesByRadius_getPostalCodesByRadiusRequest = null;
        com.mpower.ws.orangeleapV3.client.GetPostalCodesByRadiusResponse _getPostalCodesByRadius__return = port.getPostalCodesByRadius(_getPostalCodesByRadius_getPostalCodesByRadiusRequest);
        System.out.println("getPostalCodesByRadius.result=" + _getPostalCodesByRadius__return);


        }
        {
        System.out.println("Invoking saveOrUpdateCustomTableRow...");
        com.mpower.ws.orangeleapV3.client.SaveOrUpdateCustomTableRowRequest _saveOrUpdateCustomTableRow_saveOrUpdateCustomTableRowRequest = null;
        com.mpower.ws.orangeleapV3.client.SaveOrUpdateCustomTableRowResponse _saveOrUpdateCustomTableRow__return = port.saveOrUpdateCustomTableRow(_saveOrUpdateCustomTableRow_saveOrUpdateCustomTableRowRequest);
        System.out.println("saveOrUpdateCustomTableRow.result=" + _saveOrUpdateCustomTableRow__return);


        }
        {
        System.out.println("Invoking readCustomTableFieldById...");
        com.mpower.ws.orangeleapV3.client.ReadCustomTableFieldByIdRequest _readCustomTableFieldById_readCustomTableFieldByIdRequest = null;
        com.mpower.ws.orangeleapV3.client.ReadCustomTableFieldByIdResponse _readCustomTableFieldById__return = port.readCustomTableFieldById(_readCustomTableFieldById_readCustomTableFieldByIdRequest);
        System.out.println("readCustomTableFieldById.result=" + _readCustomTableFieldById__return);


        }
        {
        System.out.println("Invoking readCustomTableByName...");
        com.mpower.ws.orangeleapV3.client.ReadCustomTableByNameRequest _readCustomTableByName_readCustomTableByNameRequest = null;
        com.mpower.ws.orangeleapV3.client.ReadCustomTableByNameResponse _readCustomTableByName__return = port.readCustomTableByName(_readCustomTableByName_readCustomTableByNameRequest);
        System.out.println("readCustomTableByName.result=" + _readCustomTableByName__return);


        }
        {
        System.out.println("Invoking getDetailCustomTableRows...");
        com.mpower.ws.orangeleapV3.client.GetDetailCustomTableRowsRequest _getDetailCustomTableRows_getDetailCustomTableRowsRequest = null;
        com.mpower.ws.orangeleapV3.client.GetDetailCustomTableRowsResponse _getDetailCustomTableRows__return = port.getDetailCustomTableRows(_getDetailCustomTableRows_getDetailCustomTableRowsRequest);
        System.out.println("getDetailCustomTableRows.result=" + _getDetailCustomTableRows__return);


        }

        System.exit(0);
    }

}