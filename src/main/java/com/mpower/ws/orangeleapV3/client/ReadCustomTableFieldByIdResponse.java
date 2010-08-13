
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
 *         &lt;element name="customTableField" type="{http://www.orangeleap.com/orangeleap/typesv3}customTableField"/>
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
    "customTableField"
})
@XmlRootElement(name = "ReadCustomTableFieldByIdResponse")
public class ReadCustomTableFieldByIdResponse {

    @XmlElement(required = true)
    protected CustomTableField customTableField;

    /**
     * Gets the value of the customTableField property.
     * 
     * @return
     *     possible object is
     *     {@link CustomTableField }
     *     
     */
    public CustomTableField getCustomTableField() {
        return customTableField;
    }

    /**
     * Sets the value of the customTableField property.
     * 
     * @param value
     *     allowed object is
     *     {@link CustomTableField }
     *     
     */
    public void setCustomTableField(CustomTableField value) {
        this.customTableField = value;
    }

}
