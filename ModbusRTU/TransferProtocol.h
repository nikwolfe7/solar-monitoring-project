/*
  Defines the interface for data transfer over an arbitrary serial protocol
*/

#ifndef TransferProtocol_h
#define TransferProtocol_h

#include "WProgram.h"

class TransferProtocol
{
	public:
		void transferData( unsigned char* data_frame, unsigned short data_length );
};

#endif