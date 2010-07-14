
package com.mpower.ws.orangeleapV2.client;

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
 *         &lt;element name="recurringgift" type="{http://www.orangeleap.com/orangeleap/services2.0/}recurringGift"/>
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
    "recurringgift"
})
@XmlRootElement(name = "SaveOrUpdateRecurringGiftResponse")
public class SaveOrUpdateRecurringGiftResponse {

    @XmlElement(required = true)
    protected RecurringGift recurringgift;

    /**
     * Gets the value of the recurringgift property.
     * 
     * @return
     *     possible object is
     *     {@link RecurringGift }
     *     
     */
    public RecurringGift getRecurringgift() {
        return recurringgift;
    }

    /**
     * Sets the value of the recurringgift property.
     * 
     * @param value
     *     allowed object is
     *     {@link RecurringGift }
     *     
     */
    public void setRecurringgift(RecurringGift value) {
        this.recurringgift = value;
    }

}
