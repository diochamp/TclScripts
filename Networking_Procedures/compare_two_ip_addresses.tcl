#!/usr/bin/tclsh
# Compare two ipv4 addresses per octet and print the bigger one.

proc compareTwoIpv4Addresses {two_ipv4_add_list} { ; # List should be like {192.168.1.0 192.168.2.0}.

  set two_ipv4_add_list [string map {. " "} $two_ipv4_add_list] ; # Replace dots with whitespaces, llength of the given list is now 8.

  for {set i 0} {$i < [expr [llength $two_ipv4_add_list] / 2]} {incr i} { ; # Checks should be done until the middle of the list to avoid swap checking of indexes.

    if {[lindex $two_ipv4_add_list $i] > [lindex $two_ipv4_add_list [expr $i + 4]]} {
      # puts "1st IP is bigger. " ; Optional.
      set ip [string map {" " .} [lreplace $two_ipv4_add_list 4 7]] ; # Replace whitespaces with dots for clarity reasons and remove ( with [lreplace $a 4 7] ) the indexes of the smaller ip address.
      return $ip
      break ; # If condition is matched at least one time, no need to check further.
    } elseif {[lindex $two_ipv4_add_list $i] < [lindex $two_ipv4_add_list [expr $i + 4]]} {
      #  puts "2nd IP is bigger. " ; Optional
        set ip [string map {" " .} [lreplace $two_ipv4_add_list 0 3]] ; # Replace whitespaces with dots for clarity reasons and remove ( with [lreplace $a 0 3] ) the indexes of the smaller ip address.
        return $ip
        break ; # If condition is matched at least one time, no need to check further.
      }
  }

}

set res [compareTwoIpv4Addresses {172.168.10.0 192.168.2.0}]
puts "The bigger Ip address is \"$res\""









































# set a {192.168.1.0 192.168.2.0}
#
# # set b [expr [llength $a] / 2]
# # puts $b
#
# set a [string map {. " "} $a] ; # Replace dots with whitespaces
# # puts $a
#
# for {set i 0} {$i < [expr [llength $a] / 2]} {incr i} {
#
#   if {[lindex $a $i] > [lindex $a [expr $i + 4]]} {
#       puts "1st IP is bigger. "
#       set ip [string map {" " .} [lreplace $a 4 7]] ; # Replace whitespaces with dots for clarity reasons and remove ( with [lreplace $a 4 7] ) the indexes of the smaller ip address.
#       break
#     } elseif {[lindex $a $i] < [lindex $a [expr $i + 4]]} {
#       puts "2nd IP is bigger. "
#       set ip [string map {" " .} [lreplace $a 0 3]] ; # Replace whitespaces with dots for clarity reasons and remove ( with [lreplace $a 4 7] ) the indexes of the smaller ip address.
#       break
#       }
# }
