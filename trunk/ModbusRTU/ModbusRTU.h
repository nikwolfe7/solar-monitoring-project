/*
  Defines the interface to use in order to do MODBUS RTU
  communication with the TS-45 solar controller
*/

#ifndef TransferProtocol_h
#define TransferProtocol_h

#include "WProgram.h"

class TransferProtocol
{
	public:
		void transferData( unsigned char* data_frame, unsigned short data_length );
	private:
		unsigned short generateCRC_16( unsigned char* data_frame, unsigned short data_length );
};

#endif