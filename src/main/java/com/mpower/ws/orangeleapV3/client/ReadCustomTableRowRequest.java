
package com.mpower.ws.orangeleapV3.client;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
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
 *         &lt;element name="customTableRowId" type="{http://www.w3.org/2001/XMLSchema}long"/>
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
    "customTableRowId"
})
@XmlRootElement(name = "ReadCustomTableRowRequest")
public class ReadCustomTableRowRequest {

    protected long customTableRowId;

    /**
     * Gets the value of the customTableRowId property.
     * 
     */
    public long getCustomTableRowId() {
        return customTableRowId;
    }

    /**
     * Sets the value of the customTableRowId property.
     * 
     */
    public void setCustomTableRowId(long value) {
        this.customTableRowId = value;
    }

}
