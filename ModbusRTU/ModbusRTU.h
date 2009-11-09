/*
  Defines the interface to use in order to do MODBUS RTU
  communication with the TS-45 solar controller
*/

#ifndef ModbusRTU_h
#define ModbusRTU_h

#include "WProgram.h"

class ModbusRTU
{
	public:
		ModbusRTU();
		char getChar( int val );
	private:
		unsigned short generateCRC_16( unsigned char* data_frame, unsigned short data_length );
};

#endif