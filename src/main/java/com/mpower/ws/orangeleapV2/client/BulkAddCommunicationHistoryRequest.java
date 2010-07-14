
package com.mpower.ws.orangeleapV2.client;

import java.util.ArrayList;
import java.util.List;
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
 *         &lt;element name="bulkAdd" type="{http://www.orangeleap.com/orangeleap/services2.0/}BulkAddCommunicationHistory" maxOccurs="unbounded"/>
 *         &lt;element name="communicationHistory" type="{http://www.orangeleap.com/orangeleap/services2.0/}communicationHistory"/>
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
    "bulkAdd",
    "communicationHistory"
})
@XmlRootElement(name = "BulkAddCommunicationHistoryRequest")
public class BulkAddCommunicationHistoryRequest {

    @XmlElement(required = true)
    protected List<BulkAddCommunicationHistory> bulkAdd;
    @XmlElement(required = true)
    protected CommunicationHistory communicationHistory;

    /**
     * Gets the value of the bulkAdd property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the bulkAdd property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getBulkAdd().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link BulkAddCommunicationHistory }
     * 
     * 
     */
    public List<BulkAddCommunicationHistory> getBulkAdd() {
        if (bulkAdd == null) {
            bulkAdd = new ArrayList<BulkAddCommunicationHistory>();
        }
        return this.bulkAdd;
    }

    /**
     * Gets the value of the communicationHistory property.
     * 
     * @return
     *     possible object is
     *     {@link CommunicationHistory }
     *     
     */
    public CommunicationHistory getCommunicationHistory() {
        return communicationHistory;
    }

    /**
     * Sets the value of the communicationHistory property.
     * 
     * @param value
     *     allowed object is
     *     {@link CommunicationHistory }
     *     
     */
    public void setCommunicationHistory(CommunicationHistory value) {
        this.communicationHistory = value;
    }

}
