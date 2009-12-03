/*
  ControllerTransferProtocol.h
  
  Defines the interface for data transfer over an arbitrary transfer protocol
  
  NOTE: The methods described here are intended to be fairly generic. A controller 
  managing the production of power from any given power source, solar, wind, etc, should 
  be able to produce a response to the methods described here. Most any statistic 
  about the state of the system can be deduced from this list of critical diagnostic information.   
*/

#ifndef ControllerTransferProtocol_h
#define ControllerTransferProtocol_h

#include "WProgram.h"

class ControllerTransferProtocol
{
	public:
	
		/* Constructor */
		ControllerTransferProtocol();
	
		/* Get the voltage of the system, e.g. 6V, 12V, 24V, 48V */
		double getSystemVoltage();
	
		/* Returns the current value of the battery bank voltage */
		double getBatteryVoltage();
		
		/* Returns the current value of the voltage input to the battery bank */
		double getPwrSrcVoltage();
		
		/* Returns the cutoff voltage at which loads on the battery bank should be shut off */
		double getMinBatteryVoltage();
		
		/* Returns the current value of the current intput to the battery bank */
		double getChargeCurrent();
		
		/* Returns the current value of the current output of the battery bank */
		double getLoadCurrent();
		
		/* Returns the current temperature of the battery bank */
		double getBatteryTemp();
		
		/* Returns the total number of KWH produced thus far */
		double getTotalKilowattHrs();
		
		/* Returns the total number of AH produced thus far */
		double getTotalAmpHrs();
		
		/* Get all data, returns an array of doubles in the order presented:
			INDEX	VALUE
			0		System Voltage
			1		Battery Voltage
			2		Power Source Voltage
			3		Minimum Battery Voltage (Shut-Off Point)
			4		Charge Current
			5		Load Current
			6		Battery Temperature
			7		Total Kilowatt Hours Produced
			8		Total Amp Hours Produced
		*/
		double* getAllData();
};

#endif