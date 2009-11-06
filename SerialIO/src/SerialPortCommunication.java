import java.io.InputStream;
import java.util.Enumeration;

import javax.comm.CommPortIdentifier;
import javax.comm.SerialPort;

/*
 * Serial Communication Program in Java
 * Nikolas Wolfe
 * Senior Project
 * 
 * File Description -- not sure if this is correct but here it is, as is:
 * 1.) win32com.dll is in 
 * 		C:\WINDOWS\system32 
 * 		C:\Program Files\Java\jdk1.6.0_02\jre\bin
 * 
 * 2.) comm.jar is in 
 * 		C:\Program Files\Java\jdk1.6.0_02\lib 
 * 		C:\Program Files\Java\jdk1.6.0_02\jre\lib\ext
 * 
 * 3.) javax.comm.properties is in 
 * 		C:\Program Files\Java\jdk1.6.0_02\jre\lib
 * 
 */
public class SerialPortCommunication
{
	private static CommPortIdentifier 	portIdentifier;
	private static Enumeration			portList;
	private InputStream					inputStream;
	private SerialPort					serialPort;
	
	public static void main(String[] args)
	{
		portList = CommPortIdentifier.getPortIdentifiers();
		while( portList.hasMoreElements() )
		{
			portIdentifier = (CommPortIdentifier)portList.nextElement();
			if( portIdentifier.getPortType() == CommPortIdentifier.PORT_SERIAL )
			{
				System.out.println("Found port: " + portIdentifier.getName() );
			}
		}
	}
}
