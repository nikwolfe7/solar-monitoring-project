import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.comm.CommPortIdentifier;
import javax.comm.SerialPort;
import javax.comm.SerialPortEvent;
import javax.comm.SerialPortEventListener;


public class SerialReadWriteThread implements Runnable, SerialPortEventListener
{
	private InputStream inputStream;
	private OutputStream outputStream;
	private SerialPort serialPort;
	private CommPortIdentifier portId;
	private byte[] readBuffer;
	private String portName;
	private byte[] commandArr = { 0x01, 0x03, 0x02, 0x10, -0x68, -0x4C, 0x2E }; // 12.53 V
	private boolean transmit = false;
	private boolean transmitted = false;

	public SerialReadWriteThread( CommPortIdentifier pi )
	{
		this.portId = pi;
		this.portName = pi.getName();
		setup();
	}
	
	private void setup()
	{
		this.readBuffer = new byte[1];
		try {
			this.serialPort = (SerialPort)portId.open( portName, 2000 );
			this.inputStream = serialPort.getInputStream();
			this.outputStream = serialPort.getOutputStream();
			serialPort.addEventListener( this );
			serialPort.notifyOnDataAvailable( true );
			serialPort.notifyOnOutputEmpty( false );
			serialPort.setSerialPortParams(
					9600, 
					SerialPort.DATABITS_8,
					SerialPort.STOPBITS_2,
					SerialPort.PARITY_NONE );
		} catch ( Exception e ) {
			e.printStackTrace();
		}
	}
	
	private void delay( int millis ) throws InterruptedException
	{
		synchronized( this )
		{
			this.wait( millis );
		}
	}

	@Override
	public void run()
	{
//		try {
//			outputStream.write(8);
//			//delay( 5000 ); // allows board to reboot
//		} 
//		catch (Exception e1){ 
//		
//			Thread.currentThread().interrupt(); 
//		}
		
		System.out.println("By golly I've started!");
		while (!Thread.interrupted())
		{
			try {
				if( transmit && !transmitted )
				{
					System.out.println("Writing response...");
					outputStream.write(commandArr);
					transmit = false;
					transmitted = true;
				}
			} catch (Exception e) {
				Thread.currentThread().interrupt();
			}
		}
		serialPort.notifyOnDataAvailable(false);
		serialPort.notifyOnOutputEmpty(false);
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
					String bla = new String(readBuffer);
					if( bla.equals("A") )
					{
						transmit = true;
					}
					System.out.print(bla);
				} catch ( IOException e ) {}
				break;
		}
	}
}
