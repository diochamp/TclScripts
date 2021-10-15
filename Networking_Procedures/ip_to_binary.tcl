#!/usr/bin/tclsh

source decimal_to_binary.tcl
source ip_to_binary_procs.tcl

# Actually it is based on decimalToBinaryConverter under decimal_to_binary.tcl file.
# The total bits of the binary number generated, will always be an increment of eight.

set dec [decimalToBinaryConverter 269]

set incr_of_eight [findIncrementsOfEight]

set smallest_incr [findSmallestIncrement $incr_of_eight $dec]

set which_index [findPositionOfSmallestIncr $incr_of_eight $smallest_incr]

set next_index [findIndexRightToTheWhichIndex $which_index]

set zeros_to_pad [findTheNumberOfZerosToPad $incr_of_eight $next_index $dec]

set total_bits [findTheNumberOfTotalBits $dec $zeros_to_pad]

set dec [doThePadding $dec $total_bits]

proc ipToBinary {dec incr_of_eight smallest_incr which_index next_index zeros_to_pad total_bits} {
  return $dec
}

# puts [ipToBinary $dec $incr_of_eight $smallest_incr $which_index $next_index $zeros_to_pad $total_bits]

if {[verifyNumberOfDigits $dec $incr_of_eight]} {
  puts "Correct"
}
