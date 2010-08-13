
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
 *         &lt;element name="customTableRow" type="{http://www.orangeleap.com/orangeleap/typesv3}customTableRow"/>
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
    "customTableRow"
})
@XmlRootElement(name = "SaveOrUpdateCustomTableRowResponse")
public class SaveOrUpdateCustomTableRowResponse {

    @XmlElement(required = true)
    protected CustomTableRow customTableRow;

    /**
     * Gets the value of the customTableRow property.
     * 
     * @return
     *     possible object is
     *     {@link CustomTableRow }
     *     
     */
    public CustomTableRow getCustomTableRow() {
        return customTableRow;
    }

    /**
     * Sets the value of the customTableRow property.
     * 
     * @param value
     *     allowed object is
     *     {@link CustomTableRow }
     *     
     */
    public void setCustomTableRow(CustomTableRow value) {
        this.customTableRow = value;
    }

}
