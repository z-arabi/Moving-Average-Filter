#Moving-Average-Filter

##Introduction
We want to implement a module that implements the Moving Average filter on the signal. The input and output ports of the module are listed below:
* Input ports of the module:
  * start: 1 bit 
  * clock: 1 bit
  * reset (synchronous): 1 bit
  * In_Signal: 16 bit
* Output ports of the module:
  * done: 1 bit
  * max_val: 16 bit
  * min_val: 16 bit
  * Out_Signal: 16 bit

##Language
VHDL

