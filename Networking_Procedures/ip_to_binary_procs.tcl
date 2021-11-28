#!/usr/bin/tclsh

# source decimal_to_binary.tcl

proc findIncrementsOfEight {} {
  set incr_of_eight {}
  set stath 8
  set tmp 0
  for {set i 0} {$i < 63} {incr i} {
    set tmp [expr $tmp + $stath]
    lappend incr_of_eight $tmp
  }
  return $incr_of_eight
}

proc findSmallestIncrement {incr_of_eight dec} {
  set smallest_incr 0
  foreach el $incr_of_eight {
    if {$el < [llength $dec]} {
      set smallest_incr $el
    }
  }
  return $smallest_incr
}

proc findPositionOfSmallestIncr {incr_of_eight smallest_incr} {
  set which_index [lsearch $incr_of_eight $smallest_incr]
  return $which_index
}

proc findIndexRightToTheWhichIndex {which_index} {
  set next_index [expr $which_index + 1]
  return $next_index
}

proc findTheNumberOfZerosToPad {incr_of_eight next_index dec} {
  set zeros_to_pad [expr [lindex $incr_of_eight $next_index] - [llength $dec]]
  return $zeros_to_pad
}

proc findTheNumberOfTotalBits {dec zeros_to_pad} {
  set total_bits [expr [llength $dec] + $zeros_to_pad]
  return $total_bits
}

proc doThePadding {dec total_bits} {
  set dec [join $dec ""]
  set dec [format %0$total_bits\i $dec]
  set dec [split $dec ""]
  return $dec
}

proc verifyNumberOfDigits {dec incr_of_eight} {
  set verify_flag false
  if {[llength $dec] in $incr_of_eight} {
    set verify_flag True
  }
  return $verify_flag
}
