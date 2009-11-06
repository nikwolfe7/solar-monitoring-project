import java.io.*;
import javax.comm.*;

public class SerialReadThread implements Runnable, SerialPortEventListener
{
	private InputStream inputStream;
	private SerialPort serialPort;
	private CommPortIdentifier portId;
	private byte[] readBuffer;
	
	public SerialReadThread( CommPortIdentifier pi )
	{
		this.portId = pi;
		setup();
	}
	
	private void setup()
	{
		this.readBuffer = new byte[1];
		try {
			this.serialPort = (SerialPort)portId.open( "COM5", 2000 );
			this.inputStream = serialPort.getInputStream();
			serialPort.addEventListener( this );
			serialPort.notifyOnDataAvailable( true );
			serialPort.setSerialPortParams(
					9600, 
					SerialPort.DATABITS_8, 
					SerialPort.STOPBITS_2, 
					SerialPort.PARITY_NONE );
		} catch ( Exception e ) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	public void run()
	{
		System.out.println("By golly I've started!");
		while( !Thread.interrupted() )
		{
			try {
				synchronized( this )
				{
					this.wait();
				}
			} 
			catch ( InterruptedException e ) {
				System.out.println("Bloody hell... interrupted!");
				Thread.currentThread().interrupt();
			};
		}
		serialPort.notifyOnDataAvailable(false);
		serialPort.removeEventListener();
		serialPort.close();
		System.out.println("Goodbye!");
	}

	@Override
	public void serialEvent( SerialPortEvent event )
	{
		switch( event.getEventType() ){
			case SerialPortEvent.BI:
			case SerialPortEvent.OE:
			case SerialPortEvent.FE:
			case SerialPortEvent.PE:
			case SerialPortEvent.CD:
			case SerialPortEvent.CTS:
			case SerialPortEvent.DSR:
			case SerialPortEvent.RI:
			case SerialPortEvent.OUTPUT_BUFFER_EMPTY:
				break;
			case SerialPortEvent.DATA_AVAILABLE:
				try {
					while( inputStream.available() > 0 ) {
						inputStream.read(readBuffer);
					}
					System.out.print(new String(readBuffer));
				} catch ( IOException e ) {}
				break;
		}
	}
}
