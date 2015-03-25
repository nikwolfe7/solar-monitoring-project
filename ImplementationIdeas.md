[Back to Main Page](http://code.google.com/p/solar-monitoring-project/)

## Strategies for Implementation ##

**MOST OF THESE IDEAS HAVE NOT BEEN IMPLEMENTED... THIS IS JUST AN IDEAS PAGE.** This page is a general recording of various issues and divergent paths that arise in the process of deciding how to ultimately implement this project. The discussions are listed here in no particular order. If something becomes enough of an issue, I'll make a dedicated wiki page for it.

### Topics On This Page ###

  * [What Hardware to Use](ImplementationIdeas#What_Hardware_to_Use?.md)
  * [Discussion: Push or Pull](ImplementationIdeas#Discussion:_Push_or_Pull.md)
  * [Discussion: Necessary or Sufficient Controls](ImplementationIdeas#Discussion:_Necessary_or_Sufficient_Controls.md)
  * [Discussion: Transfer Protocols](ImplementationIdeas#Discussion:_Transfer_Protocols.md)


---


## What Hardware to Use? ##

[<< Top](ImplementationIdeas.md)

As [required](Requirements.md) by my specifications, the hardware component of this system needs to be designed with parts that are essentially generic. I do not intend to use any functionality that can only be obtained through the use of a specific microprocessor and I want this project to be replicable anywhere in the world.

### Open-Source Hardware ###

The Italian hardware company [Arduino](http://www.arduino.cc/) designs microprocessor boards and provides complete part listings and schematic documentation. As stated on their website:

> _"Arduino is an open-source electronics prototyping platform based on flexible, easy-to-use hardware and software. It's intended for artists, designers, hobbyists, and anyone interested in creating interactive objects or environments."_

This is a pretty excellent fit for this project, and that is why I have purchased an Arduino [Duemilanove](http://arduino.cc/en/Main/ArduinoBoardDuemilanove).

<img src='http://arduino.cc/en/uploads/Main/ArduinoDuemilanove.jpg' alt='Arduino Duemilanove' />

I really like this board. The open-source IDE they provide is incredibly easy to use, and is based on the [Processing](http://processing.org/reference/) language. I was able to get this thing to play a song through a Piezo speaker within 30 minutes of opening the box. Furthermore, the price is right. This gem only costs $30 assembled, and would be much less if you ordered the parts and [built](http://arduino.cc/en/uploads/Main/arduino-duemilanove-schematic.pdf) it yourself. The processor, for instance, an [ATmega328](http://www.sparkfun.com/commerce/product_info.php?products_id=9217), is a whopping $5 bucks online from [Sparkfun](http://www.sparkfun.com/commerce/categories.php).

### Hack a Phone vs. Use GSM Chip ###

GSM chips are $100 bucks flat, and are only really sold by themselves without a phone by [Telit](http://www.telit.com/). This violates the [requirement](Requirements.md) that I design this system without using any company-specific or non-generic hardware. I have opted instead to buy a disposable cell phone for $15 and hack it. Details to follow...

### Freeduino vs. Arduino ###

One of the critical requirements for this project is that the complete design must be able to be reproduced anywhere, assuming some basic infrastructure exists to get ahold of things like generic chips, resistors, capacitors, etc. Thus, it may become somewhat of a complication to assume that anyone can obtain a completely assembled microprocessor board from an [Arduino](http://en.wikipedia.org/wiki/Arduino) distributor. Furthermore, it's conceivable that the generic parts required to build an Arduino board are more readily available separately than as a finished product. Fortunately, Arduino is open-source and there are clones available with assembly guides, as well as replicas of older Arduino boards. To explore the feasibility of using Arduino clones, I have purchased a [Freeduino](http://www.freeduino.org/index.html) [MaxSerial](http://store.fundamentallogic.com/ecom/index.php?main_page=product_info&cPath=3&products_id=2) board.

This is perhaps one of the most interesting sides of open-source hardware, I think. The availability of Arduino part listings and schematic files allows basically anyone to build their own copy and/or modification of a given design. For instance, most Arduino distributors do not build the version of the [Diecimila](http://arduino.cc/en/Main/ArduinoBoardDiecimila) board that has an RS-232 serial port, because who the hell uses RS-232 ports anymore? Well, cavemen and a particular kind of [Morningstar](http://www.morningstarcorp.com/en/home) solar controller that I want to design for! Fortunately for me, Freeduino provides a replica of the elder version of the Arduino board with an RS-232 port built in!

<img src='http://store.fundamentallogic.com/ecom/bmz_cache/1/171f3a57b31f7b6952f24396bb698447.image.750x539.jpg' alt='Freeduino MaxSerial board' width='60%' height='60%' />

The first controller that I intend to design for is the [Morningstar TS-45](http://www.morningstarcorp.com/en/support/library/TriStar%20Datasheet%20English.pdf) solar controller. This controller has an RS-232 serial port that is used to poll the device for information about the performance of the solar array. Thus, the use of a Freeduino [MaxSerial](http://store.fundamentallogic.com/ecom/index.php?main_page=product_info&cPath=3&products_id=2) board has the potential to kill two birds with one stone. I can provide a full description of the board and a guide to construct it from my own experience, and furthermore have the circuitry needed to connect to a serial port built in. Considering the fact that a Freeduino MaxSerial board can be shipped as a bag of parts, not only is it **about half** the price of an assembled Arduino board ($16.50), it's a great way to explain how to build the microcontroller aspect of this project.

Here's my special wiki page dedicated to this [topic](Freeduino.md).



---


## Discussion: Push or Pull ##

[<< Top](ImplementationIdeas.md)

There are actually two different ways to accomplish the task of initializing the data transfer from the solar array site to the remote server.

### Push Model ###

The idea of a "push" in this case is the initialization of a data transfer from the solar site itself. The microcontroller interfacing with the solar controller will, at a time of its own choosing, call up the server and complete a data transfer. In this case the remote server simply "waits" for the solar site to send it data.

**Advantages:** If an emergency triggers an event at the site, system overseers can be notified immediately. It might be easier to minimize power usage if the decision of when to transmit data is in the hands of the transmitter.

**Disadvantages:** Because there is no phone number for an IP address, a cellular transmitter would need to call a modem with a phone number that would then deposit the information on the server. This requires another piece of hardware, and that we have physical access to the server. This violates the [requirement](Requirements.md) that the software system be able to run anywhere. It's also more expensive and completely unnecessary given the fact that VoIP services can call cell phones directly with just an internet connection from the perspective of the client. The exchange between the ISP and the cellular network is for all intensive purposes hidden from the client in this case.

The disadvantages of the pull system are a deal-breaker, in my opinion.

### Pull Model ###

The idea of a "pull" model in this case is the initialization of a data transfer from the remote server. The server would initiate a call to the solar site at predefined intervals and "ask" for information. In this case, the hardware component simply waits to be called.

**Advantages:** The remote server will simply use VoIP services to call the transmitter, and so no further hardware beyond what is contained at the solar site is required. Inquiries can also be initiated at will in this case.

**Disadvantages:** We need to pay for VoIP services. (Of course, paying for a modem to listen for data requires another cellular account for the SIM card/phone number so this is not exactly a drawback, other than the fact that communication costs money.) Also, we will not know about failures until we initiate a data transfer and get a response from the site. This can lead to lapses during which time solar battery depletion can occur.

I think the pull model wins on the merits that it is cheaper and allows us to run the software for this system anywhere, as called for by the [requirements](Requirements.md) of this project.

### Final Decision ###

Pull Model.


---


## Discussion: Necessary or Sufficient Controls ##

[<< Top](ImplementationIdeas.md)

This is an issue that I need to elaborate in words, because it has become an increasingly frustrating aspect of my implementation: Why can't I connect the power button control circuit to the same circuitry as the rest of the button controls?

This takes a little description, and at least one picture:

<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_keypad.png' alt='image' width='90%' height='90%' />

This image is of the keypad nodes on the motherboard of a [Motorola W260g](http://www.phonescoop.com/phones/phone.php?p=1535). Any button on this keypad can be pressed by connecting a circuit across the outer and inner circular leads. The nodes are important because the keys are arranged as a grid:

_Buttons Pressed After Connecting Nodes:_

|        | Node A | Node B | Node C | Node D |
|:-------|:-------|:-------|:-------|:-------|
| Node 1 |   1    |    4   |   7    |   `*`  |
| Node 2 |   2    |    5   |   8    |   0    |
| Node 3 |   3    |    6   |   9    |   #    |

Thus with only 7 connections, any key can be pressed on the DTMF keypad. A few other items of information must be noted here:
  * An incoming call can be connected by completing a circuit across "Node 1" and the node annotated as "On / Accept".
  * The power button is pressed by completing a circuit across the lead labeled "Power" and the "Ground" node.
  * The outer edge of the keypad is ground.

These buttons can be connected electronically using a [tri-state buffer](http://en.wikipedia.org/wiki/Three-state_logic) where any two nodes to be connected are the input and output of the buffer and a control signal (from, say, a microprocessor) is the enable. So, you can press any button on the keypad electronically without mechanical energy (i.e. pushing a button).

<img src='http://www.geocities.com/SiliconValley/2072/3statbuf.gif' alt='tri-state buffer' />

There are issues with this, however. [Tri-state buffer chips](http://www.datasheetcatalog.org/datasheet/philips/74HC_HCT125_CNV_2.pdf) require power and ground, and in order to connect the power button, you need to ensure that the ground on the buffer chip is connected to the same ground as the cell phone. The problem that arises is the fact that connecting any of the keypad buttons through the same circuit results in Nodes 1-3 being drawn to ground. Consequentially, when you connect ANY key on the keypad, only a 1, 2, or 3 registers. Nodes 1, 2, and 3 MUST be connected to Nodes A, B, C, and D in order for all of the keys (0-9,`*`,#) to register. If the ground of the circuitry used to electronically connect these nodes is also connected to the ground of the cell phone (as required by the circuitry to connect the "Power" button), the keypad is rendered useless.

Oddly, all of the keypad's functionality is sacrificed in the interest of electronically connecting the power button.

### Question: Why Do We Need The Power Button? ###

After trying in vain to resolve this problem for more days than I care to admit, I realized yet another consequence of using a [pull](ImplementationIdeas#Discussion:_Push_or_Pull.md) model for this system. If the cell phone is passively waiting for a call at all times, why would you ever want to turn it off? Or, for that matter, why can't we just break out the power button as a mechanical switch for an operator to manually override if needed?

#### Pros of Electronic Control of the Power Button ####

The power button is useful for 3 things:

  1. Turning the phone on and off
  1. Disconnecting a call
  1. Returning to the home state of the phone

Regarding the turning on and off of a phone, one of the requirements of this project is to develop some circuitry that will periodically recharge the battery along with the power source for the Arduino board. So, ideally, turning the phone on or off shouldn't be that much of a concern.

Regarding the disconnection of a call, we can accomplish this task either through the use of the power button or from the other end of the call. So, this isn't a dire requirement. A control signal could be sent to the receiver to terminate the call in the form of a key that won't be used for data, like the # or `*` keys, perhaps.

Regarding the return to home state, this will only become a problem if the phone winds up in a state where the electronic controls are no longer of any use.

#### Cons of Electronic Control of the Power Button ####

Controlling the power button from the microprocessor has several drawbacks:

  1. The rest of the keypad becomes useless
  1. No manual override
  1. Solving this problem is wasting development time

I attempted to solve the first issue here by generating DTMF tones through the Arduino PWM outputs. I found a [software library](http://code.google.com/p/arduino-tone/) to generate DTMF tones and ran it on the board. The tones were of audibly bad quality, and could not navigate a phone menu. This is not to say that perhaps this library was to blame for the production of poor quality tones. It is to say that generating a reliable library of DTMF tones with the Arduino will probably require some additional hardware, plus the development time required to fine tune the outputs to produce tones that will be recognized as DTMF. Furthermore, the DSP on the cell phone board is of excellent quality and can send high amplitude DTMF signals through a connected phone line. This potential is worthy of consideration.

Next, the connection of the power button to the microprocessor only makes it impossible without recompiling and re-installing the software system for the cell phone to be turned off without manually connecting a wire across the leads and potentially disturbing the wiring on the phone. Furthermore, if someone needed to turn the phone off for any other reason to get a "clean slate" on the phone, a manual push-button could be of use.

Finally, and most importantly, I have a feeling there is a better solution to this problem, but it is a waste of time to bother much beyond this. Perhaps later when I have a working prototype and I want to make improvements, I will return to this, but not now. At this point, with a manual push button for the power, I can gain full access to the keypad electronically and use the microprocessor to do the work I need. I do not need the power button to be controlled by the microprocessor at this point and struggling with it is costing me precious days.

#### Resolution ####

I'm making a manual push-button for the power and moving on...


---


## Discussion: Transfer Protocols ##

[<< Top](ImplementationIdeas.md)

#### Contents ####
  * [Binary Encoding](ImplementationIdeas#One_Approach:_Binary_Encoding.md)
  * [Decimal Encoding](ImplementationIdeas#Another_Approach:_Decimal_Encoding.md)
  * [DTMF Decimal-Encoded Data Frames](ImplementationIdeas#DTMF_Decimal-Encoded_Data_Frames.md)
  * [Reliable Transfer](ImplementationIdeas#Reliable_Transfer.md)
  * [Interpolation As Error-Checking](ImplementationIdeas#Interpolation_As_Error-Checking.md)
  * [Article Summary](ImplementationIdeas#Decimal_Transfer_Protocol_Summary.md)

In order to wirelessly transmit data about the performance of a solar power system to a remote server, we need some sort of [transfer protocol](http://en.wikipedia.org/wiki/Communications_protocol). One of the critical aspects of using a hacked cellular phone and DTMF tones as a means of transferring data via audio is the development of an appropriate and effective protocol. Tones have to correspond to data and must be able to represent any possible value that might need to be transferred.

### One Approach: Binary Encoding ###

One of the useful things about DTMF is the fact that the existence of 16 distinct tones provides an easy translation to hexadecimal values, which can each represent 4 bits of binary information. Such a system would work as follows:

| DTMF Tones  | Hex Value  | Binary Translation |
|:------------|:-----------|:-------------------|
| 0           | 0          | 0000               |
| 1           | 1          | 0001               |
| 2           | 2          | 0010               |
| 3           | 3          | 0011               |
| 4           | 4          | 0100               |
| 5           | 5          | 0101               |
| 6           | 6          | 0110               |
| 7           | 7          | 0111               |
| 8           | 8          | 1000               |
| 9           | 9          | 1001               |
| A           | A          | 1010               |
| B           | B          | 1011               |
| C           | C          | 1100               |
| D           | D          | 1101               |
| `*`         | E          | 1110               |
| #           | F          | 1111               |

This system would allow any binary string to be encoded as DTMF tones, where each byte is the conjunction of two tones in sequence. The software that receives a transmission of audio information in such a format would simply decode the audio tones and map them to the appropriate binary values.

_For example,_

The ASCII code for the letter "A" is 01000010. In hexadecimal, this would translate to $41, or 0100 + 0001, which would be translated into DTMF as the tones for 4 and 1.

There are problems with this system, however. The DTMF tones A, B, C, D are not part of a standard telephone keypad and are often reserved for special use. An unfortunate combination of these tones could cause a call to be disconnected or connected to an emergency phone line used by, for instance, the police. There is no way to prepare for such an instance because these protocols are, for obvious reasons, hidden from the public.

So assuming we opted to only use tones on the standard keypad, (a plus for systems that use digital switches to electronically push the keys on a phone) the next option would be to use an octal number base, where 8 tones are used to encode every combination of 3 binary bits.

The issue with this is that bytes don't break down evenly. To encode a byte with an octal-based DTMF mapping, we would need 3 tones, which would correspond to 9 bits (i.e. DTMF: 0,1,2 => Octal-Binary: 000, 001, 010 => Byte: 00001010). In this case, the decoding process would have to chop one bit off the end of every third tone transmitted. Unless we made special use of this last bit or planned to reserve this space for some future purpose, the use of octal-encoding seems a little awkward to me.

The next system would be a 4-tone 2-bit binary encoding, such as:

| DTMF Tones | Binary Translation |
|:-----------|:-------------------|
| 1          | 00                 |
| 2          | 01                 |
| 3          | 10                 |
| 4          | 11                 |

This system, of course, is very inefficient and requires 4 tones to encode a single byte. For a 32-bit floating point number, this system would require a sequence of 16 tones. Yikes!

Of course, some of my recent experience writing software that toggles the electronic pushing of buttons on a cellular keypad indicates to me that the use of binary in the first place might be an unnecessary and perhaps overkill homage to the ubiquitous byte-system of the computing universe. I'll explain...

### Another Approach: Decimal Encoding ###

Why use binary to encode the data we're trying to transfer? Well, there are several reasons:

  1. Full translation of the ASCII table
  1. May be more intuitive to future users
  1. I can't think of anything else

The only truly compelling reason to use binary is the ability to translate the entire ASCII table. But what is the application in this case? All that we are interested in are numbers corresponding to things like the voltage and amperage of solar panels, batteries, and so on. The order and format in which these numbers are encoded is arbitrary!

I believe that in order to simplify the job of the most volatile part of this system, the data transmitter itself, we should defer the processing of information to the data collector, in this case a remote server. The transmitter should only store the least possible information and should do little if any analysis.

The benefit of this approach is that we can just transfer numbers--dumb, simple, unprocessed raw data. There is no reason to introduce a need for letters. At least, not in the simplest case, which is what I am concerned with here. So, when we examine any given cellular keypad, what do we have the most obvious access to? Numbers! So why not just input numeric values directly?

In this case the translation becomes trivial:

| DTMF Tones | Decimal Translation |
|:-----------|:--------------------|
| 1          | 1                   |
| 2          | 2                   |
| 3          | 3                   |
| 4          | 4                   |
| etc...     | etc...              |

But what about fractional values? Or indicating the magnitude and units of numbers? Or indicating the starting and stopping points of a transmission? I've given some thought to the encoding of decimal values and I think the following system could work...

#### DTMF Decimal-Encoded Data Frames ####

The primary motivation for using a decimal system is the fact that data can be encoded directly, and it requires fewer digits. I discuss these concerns in more detail in the [Reliable Transfer](ImplementationIdeas#Reliable_Transfer.md) section. Now, to explain my idea for a decimal encoded system...

Let's assume for a moment that we wanted to transmit the following values for a hypothetical solar power system:

| Time              | 10:00 AM    |
|:------------------|:------------|
| Panel Voltage     | 18.75 V     |
| Panel Amperage    | 15.50 A     |
| Battery Voltage   | 13.40 V     |
| Battery Amperage  | 12.30 A     |
| Battery Temp      | 25.00 C     |
| Total Kilowatt-Hrs| 1275.60 KWH |

There is a lot of data in the above table, if we wanted to transfer it verbatim. Off the bat, we don't care about time. That can be easily enough determined by the time the transfer is initiated, or can be calculated if bulk data were being transmitted at a given time based on a sampling rate. Furthermore, we don't need any of these labels if we know the order in which they occur. The character string "Panel Voltage" is rendered unnecessary if we simply establish that the first value, 18.75V, corresponds to the voltage of the solar panels. Secondly, we already know that voltage is measured in Volts, so we don't need that information either. We can establish the units based on the ordering. Knocking all of the unnecessary characters out of the picture (the need for total kilowatt-hours is debatable), we could transmit this entire table as the following string of numbers:

|18.75|15.50|12.40|12.30|25.00|1275.60|
|:----|:----|:----|:----|:----|:------|

Here, the receiving end of the transfer would simply map the first value as corresponding to the panel voltage, the second the amperage, and so on. Of course, how should we indicate the decimal points? Continuing with our emphasis on simplicity, I submit that the following string can be considered equivalent to the above:

|1875|1550|1240|1230|2500|127560|
|:---|:---|:---|:---|:---|:-----|

The problem with the above is the fact that there's no notion of where one number starts and the next begins. On what order of magnitude are these numbers? How many places after the decimal point are there? In this case, since the values of all the first five numbers are on the order of 10<sup>1</sup> and the last number is on the order of 10<sup>3</sup>, I'm going to make an exception in order to continue my explanation: Let's consider the last number a special case and drop it completely. Now, since all of the first five numbers are of the same order of magnitude, let's put at "2" at the beginning of the string to indicate the number of digits on either side of the decimal point. (You could also argue that a "1" should be used to indicate the power of 10, but 2 decimal places is 10<sup>-2</sup>, so I think a 2 is more descriptive in this case.)

Now, the string becomes:

|2|1875|1550|1240|1230|2500|
|:|:---|:---|:---|:---|:---|

With the 2 at the beginning of this string, we now know that each of the encoded numbers are composed of 4 total digits, with 2 before the decimal and two after. We can decode this string and get all of the original information back. (This is of course with the knowledge that we elided the total kilowatt hours value as a special case. The basic point still stands.)

There are obvious variations on this idea. What if for some odd reason the voltage were 110 volts? How would a system only capable of indicating 2 places in front of the decimal be able to represent this number? Well, fortunately, this is not a realistic concern. Most solar panels operate in the range of 12-48 Volts, and unless struck by lightning at the exact instant of measurement, the voltage of any single solar panel will never be on the order of 10<sup>2</sup>. It is almost ALWAYS going to be the case that the maximum expected voltage will be knowable to within an order of magnitude.

Solar panels can be strung in series to create higher voltages, of course. If this were the case, the first number would simply be increased to a magnitude that can represent any expected value. For instance, some current [grid-tied systems](http://en.wikipedia.org/wiki/Grid_tie_inverter) have panel voltages on the order of 700V. Values of this magnitude could be represented with one extra digit.

But in this latter situation, assuming we kept with the convention of having equal numbers on either side of the decimal place, digits beyond the hundredths place are sort of useless. What if we are monitoring a 250V solar power system? Despite the fact that you'd probably use a more high-octane monitoring system than this for such an array, we don't need 3 decimal places. Milli-volts are not exactly useful units when it comes to power generation!

So, a useful variation might be to just allocate 2 numbers after the decimal place and make the first number correspond to the power of 10 in front of the decimal place. So, assuming we wanted to represent the previous string, it'd become the following:

|1|1875|1550|1240|1230|2500|
|:|:---|:---|:---|:---|:---|

In this case we'd assume that all of the numbers are accurate to within 2 decimal places and no value will ever be greater than 99. So, each number can be determined to be 4 digits long, and all of the original information can be recovered. If, for example, we decided that we might have a 1000V spike during the day (highly unlikely, but a number on the order of 10<sup>3</sup>), we'd create the following string:

|3|001875|001550|001240|001230|002500|
|:|:-----|:-----|:-----|:-----|:-----|

In this case, each value is expected to be composed of 6 digits, 4 in front of the decimal and 2 after. We'd then take a 6-digit slice of this string, say 001875, multiply it by 10<sup>-2</sup>, and voila we'd get 18.75V for the panel voltage back.

Ensuring a reliable transfer of data is slightly more tricksy...

#### Reliable Transfer ####

What about data integrity? In my experience thus far, I have noticed some unpromising things about using a microprocessor to dial numbers on a keypad electronically. Digits are sent out of order, or potentially not at all. Below is a picture of my wiring and the output of a program I wrote to press the middle string of digits twice in sequence. In this case the output is correct but many times it is not.

<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_dialtones.png' alt='image' width='60%' height='60%' />

While I think that out-of-order tone problems can be mitigated by improving the dialing software, one of the things that must be realized about using a physical keypad to dial tones is the fact that a phone buffers the values of the keys that are pressed and releases them at pre-defined intervals.

So, since we can't control speed, we have to attempt to control reliability, because air-time is money. The interest of minimizing cost, furthermore, compels us to minimize the number of digits we have to send. This is part of the reason I think decimal is a better number base than binary in this case. Consider the following example...

Assuming we wanted to transfer the table referred to in the previous section with the most efficient possible DTMF encoding, hexadecimal. The table, again, was:

| Time              | 10:00 AM    |
|:------------------|:------------|
| Panel Voltage     | 18.75 V     |
| Panel Amperage    | 15.50 A     |
| Battery Voltage   | 13.40 V     |
| Battery Amperage  | 12.30 A     |
| Battery Temp      | 25.00 C     |
| Total Kilowatt-Hrs| 1275.60 KWH |

Assuming we streamlined the data into a single-dimension vector and eliminated time and total kilowatt-hours, the table becomes:

|18.75|15.50|13.40|12.30|25.00|
|:----|:----|:----|:----|:----|

In binary, these numbers are doubles, which means they require a standard [IEEE-754](http://en.wikipedia.org/wiki/IEEE_754-2008) 32-bit encoding. So, each value requires 4 bytes, and each byte requires 2 tones.

5 doubles X 4 bytes per double X 2 DTMF tones per byte = 40 total tones.

In comparison, the previous system I proposed using a decimal number base with the same data only uses 21 total tones, which is basically half. The following table lays out the comparisons using the above data for various number bases:

| Number Base | Total Tones Required |
|:------------|:---------------------|
| Hex         | 40                   |
| Oct         | 60                   |
| Quad        | 80                   |
| Dec         | 21                   |

Clearly the use of a decimal system is preferable for simple number transfers where the magnitude of the values is known in advance. Of course, using a hexadecimal encoding requires using the Arduino to generate the tones because you can't dial A, B, C, or D on a standard keypad. In such a situation, the speed of the transfer can be increased, but this requires additional digital-to-analog conversion hardware. Furthermore, being able to generate tones with the Arduino only would only improve the attractiveness of using a decimal system, (although the use of ASCII is enabled by using a hexadecimal encoding.)

So, assuming we were still dialing keys on the keypad electronically, we have to worry about things like keys being dialed out of order or not at all--these are limitations of not being able to control the reliability of disposable cell-phone hardware. A reliable transfer protocol should be able to detect when such failures occur.

The recourse for dealing with a failure to transmit data correctly in this case is relatively limited. Unless we want to implement an acknowledgement hand-shaking mechanism that occurs during the course of a call, we simply have to detect a failure and begin the transfer again. Since this is not a performance-centric transfer protocol, we might as well just focus on error detection.

One way to catch errors is to force certain signature digits to occur first and last. This is similar to the way binary serial protocols ensure the integrity of byte transfers with start, stop, and parity bits. In this case, start and stop digits should not be numeric, because then they could be confused for being out of order. Fortunately, DTMF provides us with the "`*`" and "#" keys. We could simply provide that any transmission starts and ends with a # key, such that in the previous example of using a decimal-encoded system we would wind up with the following:

|#|1|1875|1550|1240|1230|2500|#|
|:|:|:---|:---|:---|:---|:---|:|

This might seem trivial, but we can deduce a lot of information from the addition of these two tones. First, when the receiver software detects the first tone, it ensures that it is a "#" tone, or it terminates the call and tries again. Likewise, if the transmission does not end with a "#", we know there is a problem. But supposing the "#" key were to arrive out of order and we terminated the call before all of our data had been transferred? Well, the arrival of the second "#" indicates that we must analyze the number of tones we received based on the first number. If, in this case, we received a 1 first, we know that number of tones in the rest of the sequence must divide evenly by 4. If this is not the case, we throw out the data and try again.

If a transfer contains both "#" keys at the right positions, and the number of tones in the sequence after the initial digit divides evenly (assuming of course that there are as many data fields as we expect), we know that we have ALL of the tones that we should expect in our sequence. This does not ensure that they are in order or correct, however. Such error checking requires some additional processing.

#### Interpolation As Error-Checking ####

A pessimistic approach to evaluating the integrity of a given data transfer would argue that if any item of data does not correspond to an "expected" or "normal" value, then it should be thrown out.

Consider the performance of a solar power system over the long term. Panel voltage and current should be at or near zero at night, and whatever the expected value is during the day. These things follow very well defined patterns. Let's say we're using a 12V system: Peak panel voltage should be in the range of 17-21V during the brightest hours of the day. The output actually follows a normalized bell curve. So, once we have reliable performance data for a given solar power system, (such data is readily available and/or easily derived) we can perform error calculations on any items of data that we read in. If we know, for instance, that between the hours of 9:00 and 10:00 AM the voltage of our power system ought to be between 12V and 16V, if we receive a value like 21V or 61V, we have just reason to doubt the validity of our data transfer, and can justify a re-try.

This sort of error checking can be accomplished using [interpolation](http://en.wikipedia.org/wiki/Interpolation). We can check each value we receive against an expected value, and provided it does not deviate significantly from an interpolated curve that we derive from historical data, we can argue for trusting the received value as accurate. This goes back to the lazy engineer's mantra of what is "good enough". Our accuracy does not have to be perfect, but we can also take one step further...

Let's assume we get bad data once, and we can detect it. Let's say our luck fails us and we get bad data upon retrying. And again, and again. Let's assume then that our system is designed to quit trying after 3 failed attempts. We mark a given update time as being "unspecified" and wait until the next scheduled update. Then, when the next update time arrives, assuming we get trustworthy data, we have two data points in time on either side of our failed attempt. We also have historical data that indicates what we "should" expect. Assuming something extreme has not occurred, in which case we must take other action, we can interpolate the values for a failed update time. It is a fairly safe assumption that if we have normal data at two separate times during the day that the time our system screwed up was not some outlandish skyrocket of power output or a lightning strike.

One issue of concern would be a low-voltage shut-off warning to a system overseer. If the battery voltage of a 12V system drops anywhere below 11V, the electrolyte of the batteries is being depleted and the system must be shut off. So, supposing a value of 12.10V gets jumbled and becomes 11.02V or some variation. This would trigger an alert. Supposing it were a false alarm, no real harm has been done. If however, the system misinterpreted a signal of 10.12V as 12.10V, this does create a serious pickle. But, interpolating based on later information should reveal this value as being inconsistent and a warning message would be triggered. This system is a total failure if it cannot ensure any more reliable information than this.

Things like rain and cloud-cover can cause trouble, but nothing that cannot be reasonably and intelligently designed against. In cases where all else fails, calling upon human intervention is a great option if you can get away with it.

### Decimal Transfer Protocol Summary ###

In summation, the DTMF encoding that I am proposing for this system utilizes the following data frame:

| Start Tone | Decimal Exponent | Data Item 1 | Data Item 2 | etc ... | Stop Tone |
|:-----------|:-----------------|:------------|:------------|:--------|:----------|
| #          | e.g. 1           | e.g. 1875   | e.g. 1650   | etc ... | #         |

The starting tone will always be a "#" key, followed by a single digit corresponding to the the decimal magnitude of the subsequent values. (This is obviously based on what the highest magnitude value is going to be, which should be determined during the configuration phase of any monitoring system.) A string of data items (in this case it can be arbitrary) follows the exponent, and we wait until a "#" key arrives corresponding to the end of the sequence in which case we do error checking, and either accept the data or reject it. If an error occurs at any time during the process, we reject the entire transfer and try again until we get valid data, or until we decide to stop trying and wait for the next update to retro-analyze the situation.

Comments on this are welcome. This is just my idea.


---