/**
 *
 */
package com.mpower.util;

import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import java.io.File;
import java.net.URL;
import java.net.MalformedURLException;




/**
 * @author egreen
 *
 */
public class LocalDTDResolver implements EntityResolver {

	String mySystemIdToIntercept;
	File myLocalDtdPath;
	URL localDtdFileAsUrl;

	public LocalDTDResolver( String systemIdToIntercept, File localDtdPath )
	throws MalformedURLException
	{
		mySystemIdToIntercept = systemIdToIntercept;
		myLocalDtdPath = localDtdPath;

		localDtdFileAsUrl = new URL(myLocalDtdPath.getPath());
	}

	public InputSource resolveEntity (String publicId, String systemId)
	{
		if (systemId.equals(mySystemIdToIntercept)) {
			return new InputSource( localDtdFileAsUrl.toString() );
		} else {
			// use the default behaviour (?)
			return null;
		}
	}
}


