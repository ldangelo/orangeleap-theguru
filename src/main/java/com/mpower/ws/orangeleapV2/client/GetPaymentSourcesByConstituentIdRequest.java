
package com.mpower.ws.orangeleapV2.client;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 * 		    Retrieve the list of existing payment sources for a given constituent id.
 * 		    
 * 		    Requires a valid constituentid.
 * 		    
 * 		    Returns the list of existing payment sources.
 * 		    
 * 		    The recommendation by the orange leap team is that before you try and add a payment source to a gift, you
 * 		    first do a lookup of existing payment sources to determine it does not currently exist.  If it does currently
 * 		    exist you would use this payment source instead of creating a new one.
 * 		    
 * 		    If you try and create a new payment source that already exists you will receive a SoapFault.
 * 		  
 * 
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "")
@XmlRootElement(name = "GetPaymentSourcesByConstituentIdRequest")
public class GetPaymentSourcesByConstituentIdRequest {

    @XmlAttribute(required = true)
    protected int offset;
    @XmlAttribute
    protected Integer limit;
    @XmlAttribute(required = true)
    protected long constituentId;

    /**
     * Gets the value of the offset property.
     * 
     */
    public int getOffset() {
        return offset;
    }

    /**
     * Sets the value of the offset property.
     * 
     */
    public void setOffset(int value) {
        this.offset = value;
    }

    /**
     * Gets the value of the limit property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getLimit() {
        return limit;
    }

    /**
     * Sets the value of the limit property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setLimit(Integer value) {
        this.limit = value;
    }

    /**
     * Gets the value of the constituentId property.
     * 
     */
    public long getConstituentId() {
        return constituentId;
    }

    /**
     * Sets the value of the constituentId property.
     * 
     */
    public void setConstituentId(long value) {
        this.constituentId = value;
    }

}
