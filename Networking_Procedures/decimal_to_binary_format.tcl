#!/usr/bin/tclsh

proc decimalToBinaryConverter {decimal_number} { ; # Works for decimal numbers from 0 up to 255

  source ip_to_binary_procs.tcl

  set sum 0 ; # Saves the result of:  set sum [expr [lindex $list $i] + $sum]

  if {$decimal_number == 0} {
    for {set i 0} {$i < 8} {incr i} {
      lappend final_list 0
    }
  }

  for {set i 62} {$i >= 0} {incr i -1} {
    lappend list [expr int(pow(2,$i))]
    lappend tmplist 0
  }


  for {set i 0} {$i < [llength $list]} {incr i} {
    if {[expr [lindex $list $i] + $sum] <= $decimal_number} {
      set sum [expr [lindex $list $i] + $sum]
      set tmplist [lreplace $tmplist $i $i 1]
    }
  }

  for {set i 0} {$i <= [llength $tmplist]} {incr i} {
    if {[lindex $tmplist $i] == 1} {
      set final_list [lrange $tmplist $i end]
      break
    }
  }

  set binary_number $final_list

  set incr_of_eight [findIncrementsOfEight]
  set smallest_incr [findSmallestIncrement $incr_of_eight $binary_number]
  set which_index [findPositionOfSmallestIncr $incr_of_eight $smallest_incr]
  set next_index [findIndexRightToTheWhichIndex $which_index]
  set zeros_to_pad [findTheNumberOfZerosToPad $incr_of_eight $next_index $binary_number]
  set total_bits [findTheNumberOfTotalBits $binary_number $zeros_to_pad]
  set dec [doThePadding $binary_number $total_bits]

  return $dec

}
puts [decimalToBinaryConverter 10]
