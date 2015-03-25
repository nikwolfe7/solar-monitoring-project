[Back to Main Page](http://code.google.com/p/solar-monitoring-project/)

## Project Requirements ##

To reiterate, the basic purpose of this project is as follows:

_To design and implement an open-source monitoring system for remote solar energy power systems that can deliver useful diagnostic information to system overseers._

### System Components ###

This system can be broken into two main components:

  1. A hardware device that interfaces with the solar controller, polls it for information, processes that information into a format that can be transmitted via some telephony communication protocol (I am leaning towards DTMF for the first iteration) and then transmits that data to a remote server or potentially a specific person.
  1. A software system that will collect the data transmitted, store it for analysis and historical purposes, and allow system diagnostic information be easily displayed via a web interface. For the purposes of dealing with a potential lack of access to computers in some situations, the system will also relay critical information to system overseers via SMS.

### Constraints ###

This task will be accomplished with the following constraints in mind:

  * **The system must not rely on customized hardware (`*`), i.e. the parts it uses must be both generic (`**`) and generally available (`***`) for anyone looking to reconstruct this project. [Details](http://code.google.com/p/solar-monitoring-project/issues/detail?id=2)**
> _(`*`) I do not consider the solar charge controller itself to be a part of this monitoring system because it can function independently of any monitoring activity and is a general requirement of a functional solar power system._

> _(`**`) By "generic", of course, I mean that any adequate microprocessor or device capable of cellular communication can accomplish the tasks required by this project. The notion of an I/O pin, an RS-232 port, a DTMF keypad, an SRAM or an EEPROM, for example, are not specific to any individual type of microprocessor or cell phone, and are generally available as standard features on a variety of products._

> _(`***`) By "generally available", I mean the products are not specific to a given company or manufacturer. They are mass-produced and can be obtained from various sources._

  * **The system must eliminate after-installation costs specific to monitoring, i.e. it must not rely on the payment of a third party for telemetry services (`*`). [Details](http://code.google.com/p/solar-monitoring-project/issues/detail?id=3)**
> _(`*`) The concept of paying for cellular service or potentially server space are not included in this prohibition because they are not costs specifically related to monitoring, and more importantly, they are impossible to get around without resorting to illegal measures._

  * **The system must be able to be easily configured for any reasonable solar controller providing a serial interface. [Details](http://code.google.com/p/solar-monitoring-project/issues/detail?id=4)**

  * **The system must use only open-source software that can run on any server, anywhere. [Details](http://code.google.com/p/solar-monitoring-project/issues/detail?id=5)**

### Itemized Requirements ###

In order to consider this project complete, it must accomplish the following tasks:

**Hardware Requirements**

  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=6) The microcontroller can interface with a solar controller through a serial port, and poll the device for information.
  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=7) The microcontroller can parse data obtained and convert it to a format applicable for a telephony communication protocol.
  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=8) The microcontroller can manipulate a cellular transmitter and transfer data wirelessly to a remote server.
  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=9) The microcontroller accomplishes its work in a load-neutral way, meaning it does not represent a draw on the system that requires consideration in the load-profile.

**Software Requirements**

  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=10) The software system can call the hardware component and initiate a transmission of diagnostic information from the solar controller.
  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=11) The software system can record the transmission and be able to parse it for the encoded data.
  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=12) The software system can store this information in a database.
  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=13) The software system can display graphical and historical data about the solar power system via a web interface.
  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=14) The software system can alert overseers about emergencies via SMS messages.

**Extensibility Requirements**

  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=15) The system shall not be designed to be specifically compatible with any given communication protocol, but shall be able to easily accommodate the changes required by various cellular controllers. (This anticipates that some devices may use a protocol that requires a new implementation.)
  1. [(Details)](http://code.google.com/p/solar-monitoring-project/issues/detail?id=16) The system shall use no hardware devices or software idioms that are specific to a given language or microprocessor unless they are completely open-source and complete information can be provided such that the same task could be accomplished with different but equivalent components.