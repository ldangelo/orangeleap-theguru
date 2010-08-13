
package com.mpower.ws.orangeleapV3.client;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for abstractCustomizableEntity complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="abstractCustomizableEntity">
 *   &lt;complexContent>
 *     &lt;extension base="{http://www.orangeleap.com/orangeleap/typesv3}abstractEntity">
 *       &lt;sequence>
 *         &lt;element name="customFieldMap">
 *           &lt;complexType>
 *             &lt;complexContent>
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *                 &lt;sequence>
 *                   &lt;element name="entry" maxOccurs="unbounded" minOccurs="0">
 *                     &lt;complexType>
 *                       &lt;complexContent>
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *                           &lt;sequence>
 *                             &lt;element name="key" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *                             &lt;element name="value" type="{http://www.orangeleap.com/orangeleap/typesv3}customField"/>
 *                           &lt;/sequence>
 *                         &lt;/restriction>
 *                       &lt;/complexContent>
 *                     &lt;/complexType>
 *                   &lt;/element>
 *                 &lt;/sequence>
 *               &lt;/restriction>
 *             &lt;/complexContent>
 *           &lt;/complexType>
 *         &lt;/element>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "abstractCustomizableEntity", namespace = "http://www.orangeleap.com/orangeleap/typesv3", propOrder = {
    "customFieldMap"
})
@XmlSeeAlso({
    CustomTable.class,
    CustomTableRow.class,
    CommunicationHistory.class,
    Constituent.class,
    PicklistItem.class,
    DistributionLine.class,
    AbstractCommunicationEntity.class,
    AbstractPaymentInfoEntity.class,
    Picklist.class
})
public abstract class AbstractCustomizableEntity
    extends AbstractEntity
{

    @XmlElement(required = true)
    protected AbstractCustomizableEntity.CustomFieldMap customFieldMap;

    /**
     * Gets the value of the customFieldMap property.
     * 
     * @return
     *     possible object is
     *     {@link AbstractCustomizableEntity.CustomFieldMap }
     *     
     */
    public AbstractCustomizableEntity.CustomFieldMap getCustomFieldMap() {
        return customFieldMap;
    }

    /**
     * Sets the value of the customFieldMap property.
     * 
     * @param value
     *     allowed object is
     *     {@link AbstractCustomizableEntity.CustomFieldMap }
     *     
     */
    public void setCustomFieldMap(AbstractCustomizableEntity.CustomFieldMap value) {
        this.customFieldMap = value;
    }


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
     *         &lt;element name="entry" maxOccurs="unbounded" minOccurs="0">
     *           &lt;complexType>
     *             &lt;complexContent>
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
     *                 &lt;sequence>
     *                   &lt;element name="key" type="{http://www.w3.org/2001/XMLSchema}string"/>
     *                   &lt;element name="value" type="{http://www.orangeleap.com/orangeleap/typesv3}customField"/>
     *                 &lt;/sequence>
     *               &lt;/restriction>
     *             &lt;/complexContent>
     *           &lt;/complexType>
     *         &lt;/element>
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
        "entry"
    })
    public static class CustomFieldMap {

        @XmlElement(namespace = "http://www.orangeleap.com/orangeleap/typesv3")
        protected List<AbstractCustomizableEntity.CustomFieldMap.Entry> entry;

        /**
         * Gets the value of the entry property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the JAXB object.
         * This is why there is not a <CODE>set</CODE> method for the entry property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getEntry().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link AbstractCustomizableEntity.CustomFieldMap.Entry }
         * 
         * 
         */
        public List<AbstractCustomizableEntity.CustomFieldMap.Entry> getEntry() {
            if (entry == null) {
                entry = new ArrayList<AbstractCustomizableEntity.CustomFieldMap.Entry>();
            }
            return this.entry;
        }


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
         *         &lt;element name="key" type="{http://www.w3.org/2001/XMLSchema}string"/>
         *         &lt;element name="value" type="{http://www.orangeleap.com/orangeleap/typesv3}customField"/>
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
            "key",
            "value"
        })
        public static class Entry {

            @XmlElement(namespace = "http://www.orangeleap.com/orangeleap/typesv3", required = true)
            protected String key;
            @XmlElement(namespace = "http://www.orangeleap.com/orangeleap/typesv3", required = true)
            protected CustomField value;

            /**
             * Gets the value of the key property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getKey() {
                return key;
            }

            /**
             * Sets the value of the key property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setKey(String value) {
                this.key = value;
            }

            /**
             * Gets the value of the value property.
             * 
             * @return
             *     possible object is
             *     {@link CustomField }
             *     
             */
            public CustomField getValue() {
                return value;
            }

            /**
             * Sets the value of the value property.
             * 
             * @param value
             *     allowed object is
             *     {@link CustomField }
             *     
             */
            public void setValue(CustomField value) {
                this.value = value;
            }

        }

    }

}
