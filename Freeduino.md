[Back to Main Page](http://code.google.com/p/solar-monitoring-project/)

# Fun With Freeduino #

  * [Parts You Need](Freeduino#Parts_You_Need.md)
  * [Constructing the Board](Freeduino#Constructing_the_Board.md)
  * [Using the Freeduino](Freeduino#Using_the_Freeduino.md)
  * [Serial Pinout](Freeduino#Serial_Pinout.md)

### Building a Freeduino Max Serial Board ###

This page is dedicated to describing my experience with my newly obtained Freeduino [MaxSerial](http://store.fundamentallogic.com/ecom/index.php?main_page=index&cPath=3) board. Here, I provide a complete description of this board's construction as well as part listings and schematic files. These resources are also available at the Fundamental Logic [website](http://store.fundamentallogic.com/ecom/index.php?main_page=product_info&products_id=3).

**NOTE:** This is more or less a replica of the tutorial on the Fundamental Logic page, I just prefer to document my own experience rather than rely on forwarding the reader elsewhere.

### Parts You Need ###

[<< Top](Freeduino.md)

|Part #| Part Name                     | Quantity | Datasheet or Info | Photo |
|:-----|:------------------------------|:---------|:------------------|:------|
|1 | [MaxSerial](http://store.fundamentallogic.com/ecom/index.php?main_page=index&cPath=3) PCB| 1| [Design](http://www.freeduino.org/files/duino232/Duino232-2.png), [Schematic/Board files](http://solar-monitoring-project.googlecode.com/files/MaxSerial.2008-04-09.zip)|<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 006.jpg' alt='image' height='60%' width='60%' />|
|2 | Max232 Line Driver, ATMega328 Processor, 16-pin Socket, 28-pin Socket          | 1        | [Max232](http://www.datasheetcatalog.org/datasheet/texasinstruments/max232.pdf), [ATMega328](http://www.atmel.com/dyn/resources/prod_documents/doc8161.pdf)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 005.jpg' alt='image' height='60%' width='60%' />       |
|3 | 6-pin Female Headers, 8-pin Female Headers            | 2        |                   |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 008.jpg' alt='image' height='60%' width='60%' />      |
|4 | 10 kilo-Ohm Resistor          | 1        | (Brown, Black, Orange, Gold) [resistor color codes](http://www.samengstrom.com/nxl/3660/4_band_resistor_color_code_page.en.html)                   |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 017.jpg' alt='image' height='60%' width='60%' />       |
|5 | 1 kilo-Ohm Resistors          | 4        | (Brown, Black, Red, Gold) [resistor color codes](http://www.samengstrom.com/nxl/3660/4_band_resistor_color_code_page.en.html)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 004.jpg' alt='image' height='60%' width='60%' />       |
|6 | Diode                         | 1        | [Diode](http://en.wikipedia.org/wiki/Diode)                   |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 014.jpg' alt='image' height='60%' width='60%' />       |
|7 | Electrolytic Cap              | 2        | [Electrolytic Cap](http://en.wikipedia.org/wiki/Electrolytic_capacitor)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 010.jpg' alt='image' height='60%' width='60%' />       |
|8 | 3mm LED                       | 2        | [LED](http://en.wikipedia.org/wiki/Light-emitting_diode)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 015.jpg' alt='image' height='60%' width='60%' />       |
|9 | Push-Button Reset Switch      | 1        |                   |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 016.jpg' alt='image' height='60%' width='60%' />       |
|10| 7805 Voltage Regulator       | 1        | [7805](http://www.datasheetcatalog.org/datasheets/228/390068_DS.pdf)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 012.jpg' alt='image' height='60%' width='60%' />       |
|10| 3.3V Regulator        		| 1        | [3.3V Regulator](http://www.sparkfun.com/commerce/product_info.php?products_id=526)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 019.jpg' alt='image' height='60%' width='60%' />       |
|12| Power Socket                 | 1        |                   |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 011.jpg' alt='image' height='60%' width='60%' />      |
|13| 16 MHz Resonator             | 1        | [Resonator](http://www.sparkfun.com/commerce/product_info.php?products_id=9420)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 009.jpg' alt='image' height='60%' width='60%' />       |
|14| 0.1 micro-Farad Ceramic Caps | 10       | [Capacitor](http://www.sparkfun.com/commerce/product_info.php?products_id=8375)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 013.jpg' alt='image' height='60%' width='60%' />       |
|15| Female RA DB9                | 1        | [DB9](http://futurlec.com/Connectors/DSUBPCF9.shtml)                  |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 018.jpg' alt='image' height='60%' width='60%' />       |


---


### Constructing the Board ###

[<< Top](Freeduino.md)

Now that we have all the parts, we can construct the board. In order to do this, you will need:

  * a soldering iron
  * solder
  * a multi-meter with continuity beep
  * a center-positive 7-20V DC power source
  * wire-cutters

| Step | Description | Diagram |
|:-----|:------------|:--------|
| 1 | Place the **10 kilo-Ohm resistor**. Bend the leads as close to the ceramic as you can. Insert into the location marked **`R1`** on the PCB board. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 020.jpg' alt='image' height='75%' width='75%' /> |
| 2 | Place the **1 kilo-Ohm resistors**. Bend the leads as close to the ceramic as you can. Insert into the 4 locations marked with **R**'s. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 023.jpg' alt='image' height='75%' width='75%' /> |
| 3 | Solder the resistor leads. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 024.jpg' alt='image' height='75%' width='75%' /> |
| 4 | Clip off the excess resistor leads. Cut as close to the PCB board as you can. Do **NOT** scratch the board, as you run the risk of cutting a connection. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 026.jpg' alt='image' height='75%' width='75%' />|
| 5 | Place the **diode** into the location marked with the diode symbol. Solder and clip the excess leads. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 034.jpg' alt='image' height='75%' width='75%' /> |
| 6 | Place the **16-pin** and **28-pin sockets** into their respective locations. **Make sure** the notches align with the markings on the board.|<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 039.jpg' alt='image' height='75%' width='75%' /> |
| 7 | Take a moment to verify your solder joints. Do this periodically to avoid having to re-solder any joints later on. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 042.jpg' alt='image' height='75%' width='75%' /> |
| 8 | Place the 10 **0.1 uF Ceramic Caps** into their respective locations on the board. The locations for the capacitors are marked with **C**'s. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 045.jpg' alt='image' height='75%' width='75%' /> |
| 9 | Verify your soldering connections. **Note:** Unless you are installing the **3.3 Volt Regulator**, you may leave location **`C8`** empty. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 047.jpg' alt='image' height='75%' width='75%' /> |
| 10 | Insert the **7805 Voltage Regulator**. Bend the pins so that the metal underside lays flat on the PCB board. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 055.jpg' alt='image' height='75%' width='75%' /> |
| 11 | Solder the pins of the voltage regulator. Clip off the excess. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 052.jpg' alt='image' height='75%' width='75%' /> |
| 12 | Insert the **Electrolytic Caps**. Ensure that the longer of the pins is inserted into the hole with the plus (+) sign. Another way to verify that these are correctly inserted is to make the black stripe point down. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 056.jpg' alt='image' height='75%' width='75%' /> |
| 13 | Verify that your board matches **this** picture at this point. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 057.jpg' alt='image' height='75%' width='75%' /> |
| 14 | Install the **reset button**. The pins should match the orientation of the holes on the board. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 060.jpg' alt='image' height='75%' width='75%' /> |
| 15 | Verify your soldering connections. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 061.jpg' alt='image' height='75%' width='75%' /> |
| 16 | Insert and solder the **16-MHz Resonator** in the location next to the 28-pin socket. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 062.jpg' alt='image' height='75%' width='75%' /> |
| 17 | Install the **power LED** and the **pin 13 LED** in their respective locations. Orient the longer lead DOWN. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 067.jpg' alt='image' height='75%' width='75%' /> |
| 18 | Install the **8-pin** and **6-pin headers**. Also, solder the ICSP using 3 2-pin header segments.|<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 071.jpg' alt='image' height='75%' width='75%' /> |
| 19 | Solder the **power socket** and the **female DB9 RS-232 connector**. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 077.jpg' alt='image' height='75%' width='75%' /> |
| 20 | Install the **3.3V Regulator**. Make sure the flat face of the regulator is facing up, following the markings on the PCB board. |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 085.jpg' alt='image' height='75%' width='75%' /> |
| 21 | Insert the **Max232 Line Driver** into the 16-pin socket. Be careful to line up the notch on the socket with the notch on the chip! |<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 086.jpg' alt='image' height='75%' width='75%' /> |
| 22 | Insert the **ATMega328 Microprocessor** into the 28-pin socket. Be careful to line up the notch on the socket with the notch on the chip!|<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 090.jpg' alt='image' height='75%' width='75%' /> |
| 23 | Verify that all joints are soldered well and that there are no obvious blobs, stray solder, or noticeably bad connections. Now is the time to fix suspicious solder joints before testing the board.|<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 091.jpg' alt='image' height='75%' width='75%' /> |
| 24 | Relish in the finished product!|<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 099.jpg' alt='image' height='75%' width='75%' /> |


---


### Using the Freeduino ###

[<< Top](Freeduino.md)

Congratulations!

<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_Freeduino 104.jpg' alt='image' height='75%' width='75%' />

You have successfully constructed the Freeduino [MaxSerial](http://store.fundamentallogic.com/ecom/index.php?main_page=index&cPath=3) board, a fully compatible Arduino Decimilia clone. The only obvious difference (besides the colors) between these boards is the fact that the Arduino Duemilanove (Blue, top) uses a USB as the primary input / programming interface, whereas the Freeduino (bottom) uses an RS-232 serial port. If you have a proper Serial-to-USB converter (or, less likely, your computer actually has an RS-232 port), programming the Freeduino and running your existing Arduino code is easy: Simply plug power to the board, connect the RS-232 Serial cable to your computer, open up the [Arduino IDE](http://www.arduino.cc/en/Main/Software), and click "upload" on the sketch you want to run.

If you have not used any of these technologies before and you are programming your Freeduino cold and for the first time, simply follow the Arduino [tutorial](http://arduino.cc/en/Guide/HomePage). All of the same rules as the Arduino Decimilia and Duemilanove apply, so simply select your operating system and follow the appropriate guide. Purchasing this clone from [Fundamental Logic](http://store.fundamentallogic.com/ecom/) came with a pre-programmed ATMega328, but if you need to install the bootloader yourself, follow this [guide](http://arduino.cc/en/Hacking/Bootloader).

Yay open-source hardware!


---


### Serial Pinout ###

[<< Top](Freeduino.md)

This is a DCE ([Data Communications Equipment](http://en.wikipedia.org/wiki/Data_circuit-terminating_equipment)) device.

The pinout of the Freeduino Female Serial Port (when plugged in) is as follows:

| PIN | Voltage | Logical Value |
|:----|:--------|:--------------|
| 1   | 0V      |               |
| 2   | -6.3V   | TX            |
| 3   | -6.3V   | RX            |
| 4   | -6.3V   | DTR           |
| 5   | 0V      | GND           |
| 6   | 0V      | DSR           |
| 7   | -6.3V   |               |
| 8   | 0V      |               |
| 9   | -1.1mV  | NC            |

This is sort of misleading, however... The Freeduino only uses pins 2, 3, 4, 5, so all other voltages are from the DTE side of the connection.

A Null Modem pin connection is as follows:

| Female DB9 | Male DB9 |
|:-----------|:---------|
| 1          | 4        |
| 2          | 3        |
| 3          | 2        |
| 4          | 6, 1     |
| 5          | 5        |
| 6          | 4        |
| 7          | 8        |
| 8          | 7        |
| 9          | NC       |

The pinout for the RS-232 port between the Freeduino and the Tri-Star is as follows:

<img src='http://solar-monitoring-project.googlecode.com/svn/img/ConnectionDiagram.JPG' alt='image' height='75%' width='75%' />

Which is:

| Arduino DB9 | Tri-Star DB9 |
|:------------|:-------------|
| ----------- |----------- |
| 2           | 3          |
| 3           | 2          |
| ----------- |----------- |
| 5           | 5          |
| 6           | 4          |
| ----------- |----------- |
| ----------- |----------- |
| ----------- |----------- |

Applying a voltage to pin 6 from the VS+ pin on the Max232 chip, we can achieve the correct pin out with just the addition of a null-modem cable connector. This can be done as shown below:

<img src='http://solar-monitoring-project.googlecode.com/svn/img/th_pwrPin6 001.jpg' alt='image' height='50%' width='50%' />