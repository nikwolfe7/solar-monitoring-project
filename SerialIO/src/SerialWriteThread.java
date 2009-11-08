import java.io.IOException;
import java.io.OutputStream;

import javax.comm.CommPortIdentifier;
import javax.comm.PortInUseException;
import javax.comm.SerialPort;


public class SerialWriteThread implements Runnable
{
	private OutputStream outputStream;
	private SerialPort serialPort;
	private CommPortIdentifier portId;
	private boolean outputEmpty;
	private String portName;
	
	public SerialWriteThread( CommPortIdentifier pi )
	{
		this.portId = pi;
		this.portName = pi.getName();
		setup();
	}
	
	private void setup()
	{
		try
		{
			this.serialPort = (SerialPort)portId.open( portName, 2000 );
			this.outputStream = serialPort.getOutputStream();
			serialPort.notifyOnOutputEmpty( true );
			serialPort.setSerialPortParams(
					9600, 
					SerialPort.DATABITS_8,
					SerialPort.STOPBITS_2, 
					SerialPort.PARITY_NONE );
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void run()
	{
		System.out.println("Yay! Time to write!");
		try {
			outputStream.write( "hello".getBytes() );
		} catch (IOException e) {
			e.printStackTrace();
		}
		serialPort.notifyOnOutputEmpty( false );
		serialPort.close();
		System.out.println("Goodbye!");
	}
}
