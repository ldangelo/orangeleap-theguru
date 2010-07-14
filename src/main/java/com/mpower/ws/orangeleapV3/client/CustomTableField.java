
package com.mpower.ws.orangeleapV3.client;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;


/**
 * <p>Java class for customTableField complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="customTableField">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="createDate" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/>
 *         &lt;element name="customTableFieldActive" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="customTableFieldDatatype" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldDefaultValue" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldDesc" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldFkCustomTableName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldFkEntityType" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldKey" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="customTableFieldListView" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="customTableFieldMask" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldOrder" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="customTableFieldParentFieldName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldParentFieldValue" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldPicklistNameId" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldRegex" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldRequired" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="customTableFieldSearchable" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="customTableFieldSortDir" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="customTableFieldSortPriority" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="customTableFieldTabOrder" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="customTableFieldTitle" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="customTableId" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="id" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/>
 *         &lt;element name="updateDate" type="{http://www.w3.org/2001/XMLSchema}dateTime" minOccurs="0"/>
 *         &lt;element name="updatedBy" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="validValueList" type="{http://www.orangeleap.com/orangeleap/typesv3}validValue" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "customTableField", namespace = "http://www.orangeleap.com/orangeleap/typesv3", propOrder = {
    "createDate",
    "customTableFieldActive",
    "customTableFieldDatatype",
    "customTableFieldDefaultValue",
    "customTableFieldDesc",
    "customTableFieldFkCustomTableName",
    "customTableFieldFkEntityType",
    "customTableFieldKey",
    "customTableFieldListView",
    "customTableFieldMask",
    "customTableFieldName",
    "customTableFieldOrder",
    "customTableFieldParentFieldName",
    "customTableFieldParentFieldValue",
    "customTableFieldPicklistNameId",
    "customTableFieldRegex",
    "customTableFieldRequired",
    "customTableFieldSearchable",
    "customTableFieldSortDir",
    "customTableFieldSortPriority",
    "customTableFieldTabOrder",
    "customTableFieldTitle",
    "customTableId",
    "id",
    "updateDate",
    "updatedBy",
    "validValueList"
})
public class CustomTableField {

    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar createDate;
    protected boolean customTableFieldActive;
    protected String customTableFieldDatatype;
    protected String customTableFieldDefaultValue;
    protected String customTableFieldDesc;
    protected String customTableFieldFkCustomTableName;
    protected String customTableFieldFkEntityType;
    protected boolean customTableFieldKey;
    protected boolean customTableFieldListView;
    protected String customTableFieldMask;
    protected String customTableFieldName;
    protected Long customTableFieldOrder;
    protected String customTableFieldParentFieldName;
    protected String customTableFieldParentFieldValue;
    protected String customTableFieldPicklistNameId;
    protected String customTableFieldRegex;
    protected boolean customTableFieldRequired;
    protected boolean customTableFieldSearchable;
    protected String customTableFieldSortDir;
    protected Long customTableFieldSortPriority;
    protected Long customTableFieldTabOrder;
    protected boolean customTableFieldTitle;
    protected Long customTableId;
    protected Long id;
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar updateDate;
    protected String updatedBy;
    @XmlElement(nillable = true)
    protected List<ValidValue> validValueList;

    /**
     * Gets the value of the createDate property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getCreateDate() {
        return createDate;
    }

    /**
     * Sets the value of the createDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setCreateDate(XMLGregorianCalendar value) {
        this.createDate = value;
    }

    /**
     * Gets the value of the customTableFieldActive property.
     * 
     */
    public boolean isCustomTableFieldActive() {
        return customTableFieldActive;
    }

    /**
     * Sets the value of the customTableFieldActive property.
     * 
     */
    public void setCustomTableFieldActive(boolean value) {
        this.customTableFieldActive = value;
    }

    /**
     * Gets the value of the customTableFieldDatatype property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldDatatype() {
        return customTableFieldDatatype;
    }

    /**
     * Sets the value of the customTableFieldDatatype property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldDatatype(String value) {
        this.customTableFieldDatatype = value;
    }

    /**
     * Gets the value of the customTableFieldDefaultValue property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldDefaultValue() {
        return customTableFieldDefaultValue;
    }

    /**
     * Sets the value of the customTableFieldDefaultValue property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldDefaultValue(String value) {
        this.customTableFieldDefaultValue = value;
    }

    /**
     * Gets the value of the customTableFieldDesc property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldDesc() {
        return customTableFieldDesc;
    }

    /**
     * Sets the value of the customTableFieldDesc property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldDesc(String value) {
        this.customTableFieldDesc = value;
    }

    /**
     * Gets the value of the customTableFieldFkCustomTableName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldFkCustomTableName() {
        return customTableFieldFkCustomTableName;
    }

    /**
     * Sets the value of the customTableFieldFkCustomTableName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldFkCustomTableName(String value) {
        this.customTableFieldFkCustomTableName = value;
    }

    /**
     * Gets the value of the customTableFieldFkEntityType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldFkEntityType() {
        return customTableFieldFkEntityType;
    }

    /**
     * Sets the value of the customTableFieldFkEntityType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldFkEntityType(String value) {
        this.customTableFieldFkEntityType = value;
    }

    /**
     * Gets the value of the customTableFieldKey property.
     * 
     */
    public boolean isCustomTableFieldKey() {
        return customTableFieldKey;
    }

    /**
     * Sets the value of the customTableFieldKey property.
     * 
     */
    public void setCustomTableFieldKey(boolean value) {
        this.customTableFieldKey = value;
    }

    /**
     * Gets the value of the customTableFieldListView property.
     * 
     */
    public boolean isCustomTableFieldListView() {
        return customTableFieldListView;
    }

    /**
     * Sets the value of the customTableFieldListView property.
     * 
     */
    public void setCustomTableFieldListView(boolean value) {
        this.customTableFieldListView = value;
    }

    /**
     * Gets the value of the customTableFieldMask property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldMask() {
        return customTableFieldMask;
    }

    /**
     * Sets the value of the customTableFieldMask property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldMask(String value) {
        this.customTableFieldMask = value;
    }

    /**
     * Gets the value of the customTableFieldName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldName() {
        return customTableFieldName;
    }

    /**
     * Sets the value of the customTableFieldName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldName(String value) {
        this.customTableFieldName = value;
    }

    /**
     * Gets the value of the customTableFieldOrder property.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getCustomTableFieldOrder() {
        return customTableFieldOrder;
    }

    /**
     * Sets the value of the customTableFieldOrder property.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setCustomTableFieldOrder(Long value) {
        this.customTableFieldOrder = value;
    }

    /**
     * Gets the value of the customTableFieldParentFieldName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldParentFieldName() {
        return customTableFieldParentFieldName;
    }

    /**
     * Sets the value of the customTableFieldParentFieldName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldParentFieldName(String value) {
        this.customTableFieldParentFieldName = value;
    }

    /**
     * Gets the value of the customTableFieldParentFieldValue property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldParentFieldValue() {
        return customTableFieldParentFieldValue;
    }

    /**
     * Sets the value of the customTableFieldParentFieldValue property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldParentFieldValue(String value) {
        this.customTableFieldParentFieldValue = value;
    }

    /**
     * Gets the value of the customTableFieldPicklistNameId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldPicklistNameId() {
        return customTableFieldPicklistNameId;
    }

    /**
     * Sets the value of the customTableFieldPicklistNameId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldPicklistNameId(String value) {
        this.customTableFieldPicklistNameId = value;
    }

    /**
     * Gets the value of the customTableFieldRegex property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldRegex() {
        return customTableFieldRegex;
    }

    /**
     * Sets the value of the customTableFieldRegex property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldRegex(String value) {
        this.customTableFieldRegex = value;
    }

    /**
     * Gets the value of the customTableFieldRequired property.
     * 
     */
    public boolean isCustomTableFieldRequired() {
        return customTableFieldRequired;
    }

    /**
     * Sets the value of the customTableFieldRequired property.
     * 
     */
    public void setCustomTableFieldRequired(boolean value) {
        this.customTableFieldRequired = value;
    }

    /**
     * Gets the value of the customTableFieldSearchable property.
     * 
     */
    public boolean isCustomTableFieldSearchable() {
        return customTableFieldSearchable;
    }

    /**
     * Sets the value of the customTableFieldSearchable property.
     * 
     */
    public void setCustomTableFieldSearchable(boolean value) {
        this.customTableFieldSearchable = value;
    }

    /**
     * Gets the value of the customTableFieldSortDir property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomTableFieldSortDir() {
        return customTableFieldSortDir;
    }

    /**
     * Sets the value of the customTableFieldSortDir property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomTableFieldSortDir(String value) {
        this.customTableFieldSortDir = value;
    }

    /**
     * Gets the value of the customTableFieldSortPriority property.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getCustomTableFieldSortPriority() {
        return customTableFieldSortPriority;
    }

    /**
     * Sets the value of the customTableFieldSortPriority property.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setCustomTableFieldSortPriority(Long value) {
        this.customTableFieldSortPriority = value;
    }

    /**
     * Gets the value of the customTableFieldTabOrder property.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getCustomTableFieldTabOrder() {
        return customTableFieldTabOrder;
    }

    /**
     * Sets the value of the customTableFieldTabOrder property.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setCustomTableFieldTabOrder(Long value) {
        this.customTableFieldTabOrder = value;
    }

    /**
     * Gets the value of the customTableFieldTitle property.
     * 
     */
    public boolean isCustomTableFieldTitle() {
        return customTableFieldTitle;
    }

    /**
     * Sets the value of the customTableFieldTitle property.
     * 
     */
    public void setCustomTableFieldTitle(boolean value) {
        this.customTableFieldTitle = value;
    }

    /**
     * Gets the value of the customTableId property.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getCustomTableId() {
        return customTableId;
    }

    /**
     * Sets the value of the customTableId property.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setCustomTableId(Long value) {
        this.customTableId = value;
    }

    /**
     * Gets the value of the id property.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getId() {
        return id;
    }

    /**
     * Sets the value of the id property.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setId(Long value) {
        this.id = value;
    }

    /**
     * Gets the value of the updateDate property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getUpdateDate() {
        return updateDate;
    }

    /**
     * Sets the value of the updateDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setUpdateDate(XMLGregorianCalendar value) {
        this.updateDate = value;
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

    /**
     * Gets the value of the validValueList property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the validValueList property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getValidValueList().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ValidValue }
     * 
     * 
     */
    public List<ValidValue> getValidValueList() {
        if (validValueList == null) {
            validValueList = new ArrayList<ValidValue>();
        }
        return this.validValueList;
    }

}
