#!/usr/bin/tclsh

proc findNumberOfHosts {subnet_mask} {
  source sub_mask_to_binary.tcl

  set mask [subMaskToBinary $subnet_mask]
  set nummber_of_zeros {}
  for {set i 0} {$i <= 31} {incr i} {
    if {[lindex $mask $i] == 0} {
      lappend nummber_of_zeros [lindex $mask $i]
    }
  }
  set number_of_usable_hosts [expr int(pow(2,[llength $nummber_of_zeros])) -2]
  return $number_of_usable_hosts
}
