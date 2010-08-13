
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
 *         &lt;element name="customTableFieldId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *         &lt;element name="includeValidValues" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="filterActive" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="row" type="{http://www.orangeleap.com/orangeleap/typesv3}customTableRow"/>
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
    "customTableFieldId",
    "includeValidValues",
    "filterActive",
    "row"
})
@XmlRootElement(name = "ListCustomTableFieldsRequest")
public class ListCustomTableFieldsRequest {

    protected long customTableFieldId;
    protected boolean includeValidValues;
    protected boolean filterActive;
    @XmlElement(required = true)
    protected CustomTableRow row;

    /**
     * Gets the value of the customTableFieldId property.
     * 
     */
    public long getCustomTableFieldId() {
        return customTableFieldId;
    }

    /**
     * Sets the value of the customTableFieldId property.
     * 
     */
    public void setCustomTableFieldId(long value) {
        this.customTableFieldId = value;
    }

    /**
     * Gets the value of the includeValidValues property.
     * 
     */
    public boolean isIncludeValidValues() {
        return includeValidValues;
    }

    /**
     * Sets the value of the includeValidValues property.
     * 
     */
    public void setIncludeValidValues(boolean value) {
        this.includeValidValues = value;
    }

    /**
     * Gets the value of the filterActive property.
     * 
     */
    public boolean isFilterActive() {
        return filterActive;
    }

    /**
     * Sets the value of the filterActive property.
     * 
     */
    public void setFilterActive(boolean value) {
        this.filterActive = value;
    }

    /**
     * Gets the value of the row property.
     * 
     * @return
     *     possible object is
     *     {@link CustomTableRow }
     *     
     */
    public CustomTableRow getRow() {
        return row;
    }

    /**
     * Sets the value of the row property.
     * 
     * @param value
     *     allowed object is
     *     {@link CustomTableRow }
     *     
     */
    public void setRow(CustomTableRow value) {
        this.row = value;
    }

}
