import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;

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
	private static ArrayList<Thread>	threadList;
	private static final String COM5 =  "COM5";
	
	public static void main(String[] args) throws InterruptedException
	{
		threadList = new ArrayList<Thread>();
		portList = CommPortIdentifier.getPortIdentifiers();
		while( portList.hasMoreElements() )
		{
			portIdentifier = (CommPortIdentifier)portList.nextElement();
			if( portIdentifier.getPortType() == CommPortIdentifier.PORT_SERIAL )
			{
				if( portIdentifier.getName().equals( COM5 ))
				{
					System.out.println("Found port: " + portIdentifier.getName() );
					//threadList.add( new Thread( new SerialReadThread( portIdentifier )));
					//threadList.add( new Thread( new SerialWriteThread( portIdentifier )));
					threadList.add( new Thread( new SerialReadWriteThread( portIdentifier )));
				}
			}
		}
		Thread timer = new Thread( new PortTimer() );
		timer.start();
	}
	
	private static class PortTimer implements Runnable 
	{
		@Override
		public void run()
		{
			Iterator<Thread> iter = threadList.iterator();
			while( iter.hasNext() )
			{
				iter.next().start();
			}
			try {
				System.out.println( "Port Timer sleeping...");
				Thread.sleep( 5000 );
				System.out.println( "Port Timer awake...");
			} 
			catch (InterruptedException e) {
				e.printStackTrace();
			}
			iter = threadList.iterator();
			while( iter.hasNext() )
			{
				iter.next().interrupt();
			}
			System.out.println("Goodbye!");
		}
	}
}
