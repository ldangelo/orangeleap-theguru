
package com.mpower.ws.orangeleapV2.client;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * 
 * 		  Request to add a picklist item to an existing picklist.
 * 		  
 * 		  Requires a name and picklist item.
 * 		
 * 
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "picklistname",
    "picklistitem"
})
@XmlRootElement(name = "AddPickListItemByNameRequest")
public class AddPickListItemByNameRequest {

    @XmlElement(required = true)
    protected String picklistname;
    @XmlElement(required = true)
    protected PicklistItem picklistitem;

    /**
     * 
     * 			The name of the picklist that you want to add a value too.
     * 		      
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPicklistname() {
        return picklistname;
    }

    /**
     * Sets the value of the picklistname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPicklistname(String value) {
        this.picklistname = value;
    }

    /**
     * 
     * 			The value you are wishing to add to the picklist.
     * 		      
     * 
     * @return
     *     possible object is
     *     {@link PicklistItem }
     *     
     */
    public PicklistItem getPicklistitem() {
        return picklistitem;
    }

    /**
     * Sets the value of the picklistitem property.
     * 
     * @param value
     *     allowed object is
     *     {@link PicklistItem }
     *     
     */
    public void setPicklistitem(PicklistItem value) {
        this.picklistitem = value;
    }

}
