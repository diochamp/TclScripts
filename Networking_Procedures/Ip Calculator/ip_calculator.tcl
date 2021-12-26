#!/usr/bin/tclsh

proc calculateNetworks {ip mask} {
  # cd /home/nionios/TclScripts/Networking_Procedures
  source /home/nionios/TclScripts/Networking_Procedures/Ip\ Calculator/ip_calculator_procs.tcl
  source /home/nionios/TclScripts/Networking_Procedures/decimal_to_binary_format.tcl
  source /home/nionios/TclScripts/Networking_Procedures/sub_mask_to_binary.tcl
  source /home/nionios/TclScripts/Networking_Procedures/find_number_of_hosts.tcl

  set ip [splitIpToDot $ip]
  puts "Ip address is [string map {" " .} $ip] "

  set ip_to_binary [convertIpToBinary $ip]
  # puts $ip_to_binary

  set ip_to_binary [joinIpToWhiteSpace $ip_to_binary]
  puts " Ip address in binary is $ip_to_binary "

  puts "Subnet mask is: $mask "

  set mask_bin [subMaskToBinary $mask]
  puts "Subnet mask in binary is $mask_bin "

  set first_octet [lindex $ip 0] ; # Represents the first decimal of the ip address
  set second_octet [lindex $ip 1] ; # Represents the second decimal of the ip address
  set third_octet [lindex $ip 2] ; # Represenets the third decimal of the ip address
  set fourth_octet [lindex $ip 3] ; # Represents the fourth decimal of the ip address

          ################# EXAMPLE ##########################
          #   If ip address is 192.168.1.10:                 #
          #   the first_octet is 192                         #
          #   the second_octet is 168                        #
          #   the third_octet is 1                           #
          #   the fourth_octet is 10                         #
          # ############### END OF THE EXAMPLE ###############

  set interesting_octet {1 2 3 4}

          ################# EXAMPLE ############################
          #   If ip address is 192.168.1.10:                   #
          #   interesting_octet 1 means the first octet (192)  #
          #   interesting_octet 2 means the second octet (168) #
          #   interesting_octet 3 means the third octet (1)    #
          #   interesting_octet 4 means the fourth octet (10)  #
          # ############### END OF THE EXAMPLE #################

  array set mag_num_table [magicNumberTable]

  if {[checkIfMaskEq24/16/8 $mask]} {
    set low_limit $mask
    if {$mask == 24} {
      set interesting_octet [lindex $interesting_octet end]
      set octet_to_compare $fourth_octet
    } elseif {$mask == 16} {
      set interesting_octet [lindex $interesting_octet [expr [llength $interesting_octet] -2]]
      set octet_to_compare $third_octet
    } elseif {$mask == 8} {
      set interesting_octet [lindex $interesting_octet [expr [llength $interesting_octet] -3]]
      set octet_to_compare $second_octet
    }
  } else {
    if {[handleMaskEq32 $mask]} {
      puts "[string map {" " .} $ip]\/$mask is a host"
      exit
    } else {
      set low_limit [findLowLimit $mask]
      set interesting_octet [findInterestingOctet $mask $interesting_octet]
      set octet_to_compare [findOctetToCompare $mask $first_octet $second_octet $third_octet $fourth_octet]
    }
  }
  puts "Low limit is: $low_limit"
  puts "Interesting octet is: $interesting_octet "
  puts "Octet to compare is: $octet_to_compare "

  set magic_number [getMagicNumber $mask $low_limit mag_num_table]
  puts "Magic number is: $magic_number"

  set incr_of_magic_number [findMultiplicationsOfNumber $magic_number]
  puts "Increments of magic number are \"$incr_of_magic_number\""

  set smallest "null" ; # To be used for network address
  set biggest 0 ; # To be used for broadcast address

  set biggest [calculateBiggest $interesting_octet $incr_of_magic_number $octet_to_compare]
  puts "Biggest is: $biggest"

  set smallest [calculateSmallest $interesting_octet $incr_of_magic_number $octet_to_compare]
  puts "Smallest is: $smallest"

  set network_address [findNetworkAddress $interesting_octet $ip $smallest]
  puts "Network address is: $network_address"

  set broadcast_address [findBroadacastAddress $interesting_octet $ip $biggest]
  puts "Broadcast address is: $broadcast_address"

  calculateAvailableIps $interesting_octet $network_address $biggest

  set number_of_usable_hosts [findNumberOfHosts $mask]
  set number_of_usable_hosts [commify $number_of_usable_hosts]
  puts "Number of usable hosts is: $number_of_usable_hosts"
}
calculateNetworks 192.168.10.10 22
