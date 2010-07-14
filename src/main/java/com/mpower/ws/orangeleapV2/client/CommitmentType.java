
package com.mpower.ws.orangeleapV2.client;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for commitmentType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="commitmentType">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *     &lt;enumeration value="RECURRING_GIFT"/>
 *     &lt;enumeration value="PLEDGE"/>
 *     &lt;enumeration value="MEMBERSHIP"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlType(name = "commitmentType")
@XmlEnum
public enum CommitmentType {

    RECURRING_GIFT,
    PLEDGE,
    MEMBERSHIP;

    public String value() {
        return name();
    }

    public static CommitmentType fromValue(String v) {
        return valueOf(v);
    }

}
