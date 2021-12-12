#!/usr/bin/tclsh

source decimal_to_binary_format.tcl
source sub_mask_to_binary.tcl

proc findIncrementsOfNumber {number} {
  set incr_of_num 0
  set stath $number
  set tmp 0
  for {set i 0} {$i < 63} {incr i} {
    set tmp [expr $tmp + $stath]
    lappend incr_of_num $tmp
    if {[lindex $incr_of_num end] >= 256} {
      break
    }
  }
  return $incr_of_num
}

set ip_address {192.168.10.10}
set mask 23

set ip_address [split $ip_address .]
# puts "Ip address is \"$ip_address\""
puts "Ip address is [string map {" " .} \"$ip_address\"]"

set first_octet [lindex $ip_address 0] ; # Represents the first decimal of the ip address
set second_octet [lindex $ip_address 1] ; # Represents the second decimal of the ip address
set third_octet [lindex $ip_address 2] ; # Represenets the third decimal of the ip address
set fourth_octet [lindex $ip_address 3] ; # Represents the fourth decimal of the ip address

################# EXAMPLE ##########################
#   If ip address is 192.168.1.10:                 #
#   the first_octet is 192                         #
#   the second_octet is 168                        #
#   the third_octet is 1                           #
#   the fourth_octet is 10                         #
# ############### END OF THE EXAMPLE ###############

puts "Subnet mask is \"$mask\""

set ip_to_binary {}

foreach oct $ip_address {
  lappend ip_to_binary [decimalToBinaryConverter $oct]
}

set ip_to_binary [join $ip_to_binary " "]
puts "Ip address in binary is \"$ip_to_binary\""

set mask_bin [subMaskToBinary $mask]
puts "Subnet mask in binary is \"$mask_bin\""

set interesting_octet {1 2 3 4}
################# EXAMPLE ############################
#   If ip address is 192.168.1.10:                   #
#   interesting_octet 1 means the first octet (192)  #
#   interesting_octet 2 means the second octet (168) #
#   interesting_octet 3 means the third octet (1)    #
#   interesting_octet 4 means the fourth octet (10)  #
# ############### END OF THE EXAMPLE #################

array set subnet_table {
  0 256
  1 128
  2 64
  3 32
  4 16
  5 8
  6 4
  7 2
  8 1
}

if {$mask == 24} {
  set low_limit $mask
  set interesting_octet [lindex $interesting_octet end]
  set octet_to_compare $fourth_octet
  puts "Interesting octet is \"$interesting_octet\""
} elseif {$mask == 16} {
  set low_limit $mask
  set interesting_octet [lindex $interesting_octet [expr [llength $interesting_octet] -2]]
  set octet_to_compare $third_octet
  puts "Interesting octet is \"$interesting_octet\""
} elseif {$mask == 8} {
  set low_limit $mask
  set interesting_octet [lindex $interesting_octet [expr [llength $interesting_octet] -3]]
  set octet_to_compare $second_octet
  puts "Interesting octet is \"$interesting_octet\""
} elseif {$mask == 32} {
  set ip_address [string map {" " .} $ip_address]
  puts "$ip_address\/$mask is a host. "
  exit
}

if {$mask > 0 && ($mask < 8)} {
  set low_limit 0
  set upper_limit 8
  set interesting_octet [lindex $interesting_octet 0]
  set octet_to_compare $first_octet
  puts "Interesting octet is \"$interesting_octet\""
} elseif {$mask > 8 && ($mask < 16)} {
  set low_limit 8
  set upper_limit 16
  set interesting_octet [lindex $interesting_octet 1]
  set octet_to_compare $second_octet
  puts "interesting_octet is \"$interesting_octet\""
} elseif {$mask > 16 && ($mask < 24)} {
  set low_limit 16
  set upper_limit 24
  set interesting_octet [lindex $interesting_octet 2]
  set octet_to_compare $third_octet
  puts "Interesting octet is \"$interesting_octet\""
} elseif {$mask > 24 && ($mask < 32)} {
  set low_limit 24
  set upper_limit 32
  set interesting_octet [lindex $interesting_octet 3]
  set octet_to_compare $fourth_octet
  puts "Interesting octet is \"$interesting_octet\""
}



set tmp_magic_number [expr $mask - $low_limit]
set magic_number $subnet_table($tmp_magic_number)
puts "Magic number is \"$magic_number\""

set incr_of_magic_number [findIncrementsOfNumber $magic_number]
puts "Increments of magic number are \"$incr_of_magic_number\""

puts "Octet to compare is $octet_to_compare"

set smallest "null" ; # To be used for network address
set biggest 0 ; # To be used for broadcast address

# foreach incr $incr_of_magic_number {
#   if {$octet_to_compare < $incr} {
#     set smallest 0
#     set biggest $incr
#     break
#   }
# }

if {$interesting_octet == 4} {
  for {set i 0} {$i <= [llength $incr_of_magic_number]} {incr i } {
    if {$octet_to_compare < [lindex $incr_of_magic_number $i]} {
      puts "i = $i"
      set biggest [lindex $incr_of_magic_number $i]
      set smallest [lindex $incr_of_magic_number [expr $i -1]]
      # puts [lindex $incr_of_magic_number $i]
      break
    }
  }
}

# puts "Smallest is $smallest"
# puts "Biggest is $biggest"

if {$interesting_octet == 4} {
  set network_address [lreplace $ip_address 3 3 $smallest]
  set network_address [string map {" " .} $network_address]
  set broadcast_address [lreplace $ip_address 3 3 [expr $biggest -1]]
  set broadcast_address [string map {" " .} $broadcast_address]

  puts "Network address is \"$network_address\""
  puts "Broadcast address is \"$broadcast_address\""
}
# puts "Network address is \"$network_address\""
# puts "Broadcast address is \"$broadcast_address\""


if {$interesting_octet == 3} {
  for {set i 0} {$i <= [llength $incr_of_magic_number]} {incr i } {
    if {$octet_to_compare < [lindex $incr_of_magic_number $i]} {
      puts "i = $i"
      set biggest [lindex $incr_of_magic_number $i]
      set smallest [lindex $incr_of_magic_number [expr $i -1]]
      puts [lindex $incr_of_magic_number $i]
      break
    }
  }
}

# puts "Smallest is $smallest"
# puts "Biggest is $biggest"

if {$interesting_octet == 3} {
  puts "i'm here. "
  set network_address [lreplace $ip_address 2 2 0]
  set network_address [lreplace $network_address 3 3 0 ]
  set network_address [string map {" " .} $network_address]
  puts "Network address is \"$network_address\""

  set broadcast_address [lreplace $ip_address 2 2 [expr $biggest -1]]
  set broadcast_address [lreplace $broadcast_address 3 3 255]
  set broadcast_address [string map {" " .} $broadcast_address]
  puts "Broadcast address is \"$broadcast_address\""
}

# puts "Network address is \"$network_address\""
# puts "Broadcast address is \"$broadcast_address\""

if {$interesting_octet == 2} {
  for {set i 0} {$i <= [llength $incr_of_magic_number]} {incr i } {
    if {$octet_to_compare < [lindex $incr_of_magic_number $i]} {
      puts "i = $i"
      set biggest [lindex $incr_of_magic_number $i]
      set smallest [lindex $incr_of_magic_number [expr $i -1]]
      puts [lindex $incr_of_magic_number $i]
      break
    }
  }
}

# puts "Smallest is $smallest"
# puts "Biggest is $biggest"

if {$interesting_octet == 2} {
  puts "i'm here. "
  set network_address [lreplace $ip_address 1 1 $smallest]
  set network_address [lreplace $network_address 2 2 0]
  set network_address [lreplace $network_address 3 3 0]
  set network_address [string map {" " .} $network_address]
  puts "Network address is \"$network_address\""

  set broadcast_address [lreplace $ip_address 1 1 [expr $biggest -1]]
  set broadcast_address [lreplace $broadcast_address 2 2 255]
  set broadcast_address [lreplace $broadcast_address 3 3 255]
  set broadcast_address [string map {" " .} $broadcast_address]
  puts "Broadcast address is \"$broadcast_address\""
}
