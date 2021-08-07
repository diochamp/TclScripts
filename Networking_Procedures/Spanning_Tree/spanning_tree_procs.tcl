#!/usr/bin/tclsh

proc createBridgeIds {tmp_bridge_priorities_list system_extension_id_list} {
  foreach bridge_priority $tmp_bridge_priorities_list system_extension_id $system_extension_id_list {
    # puts "Bridge priority is \"$bp\" and system extension id is \"$ext\". "
    lappend bridge_priorities_list [expr $bridge_priority + $system_extension_id]
  }
  return $bridge_priorities_list
}

proc checkIfBridgeIdsAreEqual {bridge_IDs_list} {
  set bridge_ids_are_equal True
  for {set i 0} {$i < [expr [llength $bridge_IDs_list] - 1]} {incr i} {
    if {[lindex $bridge_IDs_list $i] != [lindex $bridge_IDs_list [expr $i + 1]]} {
      set bridge_ids_are_equal False
      return $bridge_ids_are_equal
    }
  }
  return $bridge_ids_are_equal
}

proc findLargestBid {bridge_IDs_list largest_BID} {
  foreach bridge_id $bridge_IDs_list {
    if {$bridge_id > $largest_BID} {
      set largest_BID $bridge_id
    }
  }
  return $largest_BID
}

proc findLowestBid {bridge_IDs_list lowest_BID} {
  foreach bridge_id $bridge_IDs_list {
    if {$bridge_id < $lowest_BID} {
      set lowest_BID $bridge_id
    }
  }
  return $lowest_BID
}

proc howManyTimesLowestBidExists {bridge_IDs_list lowest_BID} {
  set lowest_BID_counter 0
  foreach bridge_id $bridge_IDs_list {
    if {$bridge_id == $lowest_BID} {
      incr lowest_BID_counter
    }
  }
  return $lowest_BID_counter
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

proc replaceBidValuesDifferentToLowestBid {bridge_IDs_list lowest_BID} {
  for {set i 0} {$i < [llength $bridge_IDs_list]} {incr i} {
    if {[lindex $bridge_IDs_list $i] > $lowest_BID} {
      # set x [lsearch $bridge_IDs_list [lindex $bridge_IDs_list $i]]
      lset bridge_IDs_list $i foo
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
      # set y [lsearch $mac_addresses_list [lindex $mac_addresses_list $i]]
      # puts $y
      lset mac_addresses_list $i gggg.gggg.gggg
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
