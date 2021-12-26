#!/usr/bin/tclsh

proc splitIpToDot {ip} {
  set ip [split $ip .]
  return $ip
}

proc convertIpToBinary {ip} {
  source /home/nionios/TclScripts/Networking_Procedures/decimal_to_binary_format.tcl

  set ip_to_binary {}

  foreach oct $ip {
    lappend ip_to_binary [decimalToBinaryConverter $oct]
  }
  return $ip_to_binary
}

proc joinIpToWhiteSpace {ip_to_binary} {
  set ip_to_binary [join $ip_to_binary " "]
  return $ip_to_binary
}

proc magicNumberTable {} {
  array set mag_num_table {
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
  return [array get mag_num_table]
}

proc checkIfMaskEq24/16/8 {mask} {
  set mask_eq_8_16_24_flag False
  set masks {8 16 24}
  foreach $mask $masks {
    if {$mask in $masks} {
      set mask_eq_8_16_24_flag True
    }
  }
  return $mask_eq_8_16_24_flag
}

proc handleMaskEq32 {mask} {
  set mask_eq_32_flag False
  if {$mask == 32} {
    set mask_eq_32_flag True
  }
  return $mask_eq_32_flag
}

proc findLowLimit {mask} {
  if {$mask > 0 && ($mask < 8)} {
    set low_limit 0
    return $low_limit
  } elseif {$mask > 8 && ($mask < 16)} {
    set low_limit 8
    return $low_limit
  } elseif {$mask > 16 && ($mask < 24)} {
    set low_limit 16
    return $low_limit
  } elseif {$mask > 24 && ($mask < 32)} {
    set low_limit 24
    return $low_limit
  }
}

proc findInterestingOctet {mask interesting_octet} {
  if {$mask > 0 && ($mask < 8)} {
    set interesting_octet [lindex $interesting_octet 0]
    return $interesting_octet
  } elseif {$mask > 8 && ($mask < 16)} {
    set interesting_octet [lindex $interesting_octet 1]
    return $interesting_octet
  } elseif {$mask > 16 && ($mask < 24)} {
    set interesting_octet [lindex $interesting_octet 2]
    return $interesting_octet
  } elseif {$mask > 24 && ($mask < 32)} {
    set interesting_octet [lindex $interesting_octet 3]
    return $interesting_octet
  }
}

proc findOctetToCompare {mask 1st_oct 2nd_oct 3rd_oct 4th_oct} {
  if {$mask > 0 && ($mask < 8)} {
    set octet_to_compare $1st_oct
    return $octet_to_compare
  } elseif {$mask > 8 && ($mask < 16)} {
    set octet_to_compare $2nd_oct
    return $octet_to_compare
  } elseif {$mask > 16 && ($mask < 24)} {
    set octet_to_compare $3rd_oct
    return $octet_to_compare
  } elseif {$mask > 24 && ($mask < 32)} {
    set octet_to_compare $4th_oct
    return $octet_to_compare
  }
}

proc getMagicNumber {mask low_limit array_name} {
  upvar $array_name mag_num_table_local

  set tmp_magic_number [expr $mask - $low_limit]
  set magic_number $mag_num_table_local($tmp_magic_number)
  return $magic_number
}

proc findMultiplicationsOfNumber {number} {
  set incr_of_num 0
  set stath $number
  set tmp 0
  for {set i 0} {$i < 255} {incr i} {
    set tmp [expr $tmp + $stath]
    lappend incr_of_num $tmp
    if {[lindex $incr_of_num end] >= 256} {
      break
    }
  }
  return $incr_of_num
}

proc calculateBiggest {interesting_octet incr_of_magic_number octet_to_compare} {
  for {set i 0} {$i <= [llength $incr_of_magic_number]} {incr i } {
    if {$octet_to_compare < [lindex $incr_of_magic_number $i]} {
      # puts "i = $i"
      set biggest [lindex $incr_of_magic_number $i]
      return $biggest
      break
    }
  }
}

proc calculateSmallest {interesting_octet incr_of_magic_number octet_to_compare} {
  for {set i 0} {$i <= [llength $incr_of_magic_number]} {incr i } {
    if {$octet_to_compare < [lindex $incr_of_magic_number $i]} {
      # puts "i = $i"
      set smallest [lindex $incr_of_magic_number [expr $i -1]]
      return $smallest
      break
    }
  }
}

proc findNetworkAddress {interesting_octet ip smallest} {
  if {$interesting_octet == 4} {
    set network_address [lreplace $ip 3 3 $smallest]
    set network_address [string map {" " .} $network_address]
    return $network_address
  } elseif {$interesting_octet == 3} {
    set network_address [lreplace $ip 2 2 $smallest]
    set network_address [lreplace $network_address 3 3 0]
    set network_address [string map {" " .} $network_address]
    return $network_address
  } elseif {$interesting_octet == 2} {
    set network_address [lreplace $ip 1 1 $smallest]
    set network_address [lreplace $network_address 2 2 0]
    set network_address [lreplace $network_address 3 3 0]
    set network_address [string map {" " .} $network_address]
    return $network_address
  } else {
    set network_address [lreplace $ip 0 0 $smallest]
    set network_address [lreplace $network_address 1 1 0]
    set network_address [lreplace $network_address 2 2 0]
    set network_address [lreplace $network_address 3 3 0]
    set network_address [string map {" " .} $network_address]
    return $network_address
  }
}

proc findBroadacastAddress {interesting_octet ip biggest} {
  if {$interesting_octet == 4} {
    set broadcast_address [lreplace $ip 3 3 [expr $biggest -1]]
    set broadcast_address [string map {" " .} $broadcast_address]
  } elseif {$interesting_octet == 3} {
    set broadcast_address [lreplace $ip 2 2 [expr $biggest -1]]
    set broadcast_address [lreplace $broadcast_address 3 3 255]
    set broadcast_address [string map {" " .} $broadcast_address]
  } elseif {$interesting_octet == 2} {
    set broadcast_address [lreplace $ip 1 1 [expr $biggest -1]]
    set broadcast_address [lreplace $broadcast_address 2 2 255]
    set broadcast_address [lreplace $broadcast_address 3 3 255]
    set broadcast_address [string map {" " .} $broadcast_address]
  } else {
    set broadcast_address [lreplace $ip 0 0 [expr $biggest -1]]
    set broadcast_address [lreplace $broadcast_address 1 1 255]
    set broadcast_address [lreplace $broadcast_address 2 2 255]
    set broadcast_address [lreplace $broadcast_address 3 3 255]
    set broadcast_address [string map {" " .} $broadcast_address]
  }
}

proc calculateAvailableIps {int_oct net_add biggest} {
  set fid [open /home/nionios/TclScripts/Networking_Procedures/subneting.txt w+]
  set network_address [split $net_add .]
  if {$int_oct == 4} {
    for {set i 1} {$i < [expr $biggest -1]} {incr i} {
      set add [lreplace $network_address 3 3 $i]
      set add_join [string map {" " .} $add]
      puts $fid $add_join
    }
  } elseif {$int_oct == 3} {
    set ind [lindex $network_address 2] ; # Decimal in third octet of network address.
    # puts "ind is $ind"
    for {set i $ind} {$i <= [expr $biggest -1]} {incr i} {
      set network_address [lreplace $network_address 2 2 $i]
      if {$i == [expr $biggest -1]} {
        set j_max 254
      } else {
        set j_max 255
      }
      for {set j 0} {$j <= $j_max} {incr j} {
        set network_address [lreplace $network_address 3 3 $j]
        set add_join [string map {" " .} $network_address]
        puts $fid $add_join
      }
    }
  } elseif {$int_oct == 2} {
    set ind [lindex $network_address 1] ; # Decimal in secont onctet of network address
    for {set i $ind} {$i <= [expr $biggest -1]} {incr i} {
      set network_address [lreplace $network_address 1 1 $i]
      if {$i == [expr $biggest -1]} {
        set k_max 254
      } else {
        set k_max 255
      }
      for {set j 0} {$j <= 255} {incr j} {
        set network_address [lreplace $network_address 2 2 $j]
        for {set k 0} {$k <= $k_max} {incr k} {
          set network_address [lreplace $network_address 3 3 $k]
          set add_join [string map {" " .} $network_address]
          puts $fid $add_join
        }
      }
    }
  } elseif {$int_oct == 1} {
    set ind [lindex $network_address 0] ; # Decimal in first octet of network address
    for {set i $ind} {$i <= [expr $biggest -1]} {incr i} {
      set network_address [lreplace $network_address 0 0 $i]
      if {$i == [expr $biggest -1]} {
        set l_max 254
      } else {
        set l_max 255
      }
      for {set j 0} {$j <= 255} {incr j} {
        set network_address [lreplace $network_address 1 1 $j]
        for {set k 0} {$k <= 255} {incr k} {
          set network_address [lreplace $network_address 2 2 $k]
          for {set l 0} {$l <= $l_max} {incr l} {
            set network_address [lreplace $network_address 3 3 $l]
            set add_join [string map {" " .} $network_address]
            puts $fid $add_join
          }
        }
      }
    }
  }
}
