
package com.mpower.ws.orangeleapV3.client;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="masterCustomTableRow" type="{http://www.orangeleap.com/orangeleap/typesv3}customTableRow"/>
 *         &lt;element name="detailCustomTableName" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="offset" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *         &lt;element name="limit" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "masterCustomTableRow",
    "detailCustomTableName",
    "offset",
    "limit"
})
@XmlRootElement(name = "GetDetailCustomTableRowsRequest")
public class GetDetailCustomTableRowsRequest {

    @XmlElement(required = true)
    protected CustomTableRow masterCustomTableRow;
    @XmlElement(required = true)
    protected String detailCustomTableName;
    protected long offset;
    protected long limit;

    /**
     * Gets the value of the masterCustomTableRow property.
     * 
     * @return
     *     possible object is
     *     {@link CustomTableRow }
     *     
     */
    public CustomTableRow getMasterCustomTableRow() {
        return masterCustomTableRow;
    }

    /**
     * Sets the value of the masterCustomTableRow property.
     * 
     * @param value
     *     allowed object is
     *     {@link CustomTableRow }
     *     
     */
    public void setMasterCustomTableRow(CustomTableRow value) {
        this.masterCustomTableRow = value;
    }

    /**
     * Gets the value of the detailCustomTableName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDetailCustomTableName() {
        return detailCustomTableName;
    }

    /**
     * Sets the value of the detailCustomTableName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDetailCustomTableName(String value) {
        this.detailCustomTableName = value;
    }

    /**
     * Gets the value of the offset property.
     * 
     */
    public long getOffset() {
        return offset;
    }

    /**
     * Sets the value of the offset property.
     * 
     */
    public void setOffset(long value) {
        this.offset = value;
    }

    /**
     * Gets the value of the limit property.
     * 
     */
    public long getLimit() {
        return limit;
    }

    /**
     * Sets the value of the limit property.
     * 
     */
    public void setLimit(long value) {
        this.limit = value;
    }

}
