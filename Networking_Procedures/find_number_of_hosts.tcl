#!/usr/bin/tclsh

source decimal_to_binary_format.tcl

# set ip {192.168.10.1}
# set mask 24
#
# set network [concat $ip $mask]
# set network [string map {" " /} $network]
#
# set ip [split $ip .]
# # puts $ip
# # exit

set ip {10 10 10 10}

foreach oct $ip {
  puts "oct = $oct"
  puts [decimalToBinaryConverter $oct]
}
