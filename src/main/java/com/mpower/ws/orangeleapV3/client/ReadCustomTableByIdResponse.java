
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
 *         &lt;element name="customTable" type="{http://www.orangeleap.com/orangeleap/typesv3}customTable"/>
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
    "customTable"
})
@XmlRootElement(name = "ReadCustomTableByIdResponse")
public class ReadCustomTableByIdResponse {

    @XmlElement(required = true)
    protected CustomTable customTable;

    /**
     * Gets the value of the customTable property.
     * 
     * @return
     *     possible object is
     *     {@link CustomTable }
     *     
     */
    public CustomTable getCustomTable() {
        return customTable;
    }

    /**
     * Sets the value of the customTable property.
     * 
     * @param value
     *     allowed object is
     *     {@link CustomTable }
     *     
     */
    public void setCustomTable(CustomTable value) {
        this.customTable = value;
    }

}
