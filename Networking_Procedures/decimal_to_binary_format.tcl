#!/usr/bin/tclsh

source decimal_to_binary.tcl
source ip_to_binary_procs.tcl
source ip_to_binary.tcl

set binary [ipToBinary $dec $incr_of_eight $smallest_incr $which_index $next_index $zeros_to_pad $total_bits]
puts $binary
