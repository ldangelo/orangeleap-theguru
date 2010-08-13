
package com.mpower.ws.orangeleapV3.client;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for customTable complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="customTable">
 *   &lt;complexContent>
 *     &lt;extension base="{http://www.orangeleap.com/orangeleap/typesv3}abstractCustomizableEntity">
 *       &lt;sequence>
 *         &lt;element name="customTableActive" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="customTableDesc" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableEntity" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="fields" type="{http://www.orangeleap.com/orangeleap/typesv3}customTableField" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="siteName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="updatedBy" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "customTable", namespace = "http://www.orangeleap.com/orangeleap/typesv3", propOrder = {
    "customTableActive",
    "customTableDesc",
    "customTableEntity",
    "customTableName",
    "fields",
    "siteName",
    "updatedBy"
})
public class CustomTable
    extends AbstractCustomizableEntity
{

    protected boolean customTableActive;
    protected String customTableDesc;
    protected String customTableEntity;
    protected String customTableName;
    @XmlElement(nillable = true)
    protected List<CustomTableField> fields;
    protected String siteName;
    protected String updatedBy;

    /**
     * Gets the value of the customTableActive property.
     * 
     */
    public boolean isCustomTableActive() {
        return customTableActive;
    }

    /**
     * Sets the value of the customTableActive property.
     * 
     */
    public void setCustomTableActive(boolean value) {
        this.customTableActive = value;
    }

    /**
     * Gets the value of the customTableDesc property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableDesc() {
        return customTableDesc;
    }

    /**
     * Sets the value of the customTableDesc property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableDesc(String value) {
        this.customTableDesc = value;
    }

    /**
     * Gets the value of the customTableEntity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableEntity() {
        return customTableEntity;
    }

    /**
     * Sets the value of the customTableEntity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableEntity(String value) {
        this.customTableEntity = value;
    }

    /**
     * Gets the value of the customTableName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableName() {
        return customTableName;
    }

    /**
     * Sets the value of the customTableName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableName(String value) {
        this.customTableName = value;
    }

    /**
     * Gets the value of the fields property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the fields property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getFields().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CustomTableField }
     * 
     * 
     */
    public List<CustomTableField> getFields() {
        if (fields == null) {
            fields = new ArrayList<CustomTableField>();
        }
        return this.fields;
    }

    /**
     * Gets the value of the siteName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSiteName() {
        return siteName;
    }

    /**
     * Sets the value of the siteName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSiteName(String value) {
        this.siteName = value;
    }

    /**
     * Gets the value of the updatedBy property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUpdatedBy() {
        return updatedBy;
    }

    /**
     * Sets the value of the updatedBy property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUpdatedBy(String value) {
        this.updatedBy = value;
    }

}
