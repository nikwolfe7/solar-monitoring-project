# Pin Configurations #

_Orientation is from left to right_

## Vertical Node 6-Pin Bus ##

This is the bus connected to the positive center nodes of the cell phone, the board ground, and the start key.

| Pin | Value  |
|:----|:-------|
| 0   | Ground |
| 1   | Power  |
| 2   | Node 3 |
| 3   | Node 2 |
| 4   | Node 1 |
| 5   | Start  |


## Horizontal Node 6-Pin Bus ##

This is the bus connected to the circular outer nodes on the keypad that are connected horizontally.

_N/C means "No Connect"_

| Pin | Value  |
|:----|:-------|
| 0   | Accept |
| 1   | N/C    |
| 2   | Node A |
| 3   | Node B |
| 4   | Node C |
| 5   | Node D |

## Digital I/O Pins on the Arduino ##

This is the set of wires hooked into the Arduino from the cell phone circuit

_N/C means "No Connect"_

| Arduino Pin | Value                   |
|:------------|:------------------------|
| 2           | Incoming Call Interrupt |
| 3           | Node 1                  |
| 4           | Node 2                  |
| 5           | Node 3                  |
| 6           | Node A                  |
| 7           | Node B                  |
| 8           | Node C                  |
| 9           | Node D                  |
| 10          | Accept                  |
| 11          | Power                   |
| 12          | N/C                     |
| 13          | Debug LED               |