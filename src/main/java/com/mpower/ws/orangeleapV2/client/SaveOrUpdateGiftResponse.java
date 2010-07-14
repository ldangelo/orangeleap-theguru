
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
 *         &lt;element name="gift" type="{http://www.orangeleap.com/orangeleap/services2.0/}gift"/>
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
    "gift"
})
@XmlRootElement(name = "SaveOrUpdateGiftResponse")
public class SaveOrUpdateGiftResponse {

    @XmlElement(required = true)
    protected Gift gift;

    /**
     * Gets the value of the gift property.
     * 
     * @return
     *     possible object is
     *     {@link Gift }
     *     
     */
    public Gift getGift() {
        return gift;
    }

    /**
     * Sets the value of the gift property.
     * 
     * @param value
     *     allowed object is
     *     {@link Gift }
     *     
     */
    public void setGift(Gift value) {
        this.gift = value;
    }

}
