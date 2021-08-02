#!/usr/bin/tclsh

proc createBridgeIds {bridge_priorities_list system_extension_id_list bridge_IDs_list} {
  foreach bridge_priority $bridge_priorities_list system_extension_id $system_extension_id_list {
    # puts "Bridge priority is \"$bp\" and system extension id is \"$ext\". "
    lappend bridge_IDs_list [expr $bridge_priority + $system_extension_id]
  }
  return $bridge_IDs_list
}

proc checkIfBridgeIdsAreEqual {bridge_IDs_list bridge_ids_are_equal} {
  set are_equal "The bridge Ids are equal. "
  for {set i 0} {$i < [expr [llength $bridge_IDs_list] - 1]} {incr i} {
    if {[lindex $bridge_IDs_list $i] != [lindex $bridge_IDs_list [expr $i + 1]]} {
      set are_equal "The bridge Ids are not equal. "
      return $are_equal
    }
  }
  return $are_equal
}

proc findLargestBid {bridge_IDs_list largest_BID} {
  foreach bridge_id $bridge_IDs_list {
    if {$bridge_id > $largest_BID} {
      set largest_BID $bridge_id
    }
  }
  return $largest_BID
}

proc replaceValuesEqualToLargestBidWithFoo {bridge_IDs_list largest_BID} {
  for {set i 0} {$i < [llength $bridge_IDs_list]} {incr i} {
    if {[lindex $bridge_IDs_list $i] == $largest_BID} {
      set x [lsearch $bridge_IDs_list [lindex $bridge_IDs_list $i]]
      lset bridge_IDs_list $x foo
    }
  }
  return $bridge_IDs_list
}

proc defineSwitchesThatCannotBeRootBridges {bridge_IDs_list not_candidate_root_bridge} {
  set not_candidate_root_bridge "The switches in indexes \"[lsearch -all $bridge_IDs_list foo]\" cannot be root bridges. "
  return $not_candidate_root_bridge
}

proc replaceNonCandidateSwitchesMac {bridge_IDs_list mac_addresses_list} {
  for {set i 0} {$i < [llength $bridge_IDs_list]} {incr i} {
    if {[lindex $bridge_IDs_list $i] == "foo"} {
      set y [lsearch $mac_addresses_list [lindex $mac_addresses_list $i]]
      puts $y
      lset mac_addresses_list $y gggg.gggg.gggg
      # puts $mac_addresses_list
    }
  }
  return $mac_addresses_list
}



proc compareTwoMacAddresses {mac_addresses_list} {
  set mac_addresses_list [string map {. " "} $mac_addresses_list]
  for {set i 0} {$i < [expr [llength $mac_addresses_list] / 2]} {incr i} {
    if {[lindex $mac_addresses_list $i] > [lindex $mac_addresses_list [expr $i + 3]]} {
      set mac_address [string map {" " .} [lreplace $mac_addresses_list 0 2]]
      # puts "Second is smaller. "
      return $mac_address
      break
    } elseif {[lindex $mac_addresses_list $i] < [lindex $mac_addresses_list [expr $i + 3]]} {
      set mac_address [string map {" " .} [lreplace $mac_addresses_list 3 5]]
      # puts "First is smaller. "
      return $mac_address
      break
    }
  }
}

proc findLowestMac {mac_addresses_list} {
  set candidate_lowest_mac 9999.9999.9999

  foreach mac $mac_addresses_list {
    set tmp_list [concat $mac $candidate_lowest_mac]
    set candidate_lowest_mac [compareTwoMacAddresses $tmp_list]
  }
  return $candidate_lowest_mac
}
