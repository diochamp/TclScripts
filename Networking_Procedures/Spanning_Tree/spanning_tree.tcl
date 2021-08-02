#!/usr/bin/tclsh

source spanning_tree_procs.tcl

set bridge_priorities_list {32768 32768 32768 32768 32768}
set system_extension_id_list {1 1 1 1 1}
set bridge_IDs_list {}
set bridge_IDs_list [createBridgeIds $bridge_priorities_list $system_extension_id_list $bridge_IDs_list]

set mac_addresses_list {2999.9999.9999 1555.2222.3333 7777.7777.7777 4444.4444.4444 0999.9999.9999}
set bridge_ids_are_equal ""

set bridge_ids_are_equal [checkIfBridgeIdsAreEqual $bridge_IDs_list $bridge_ids_are_equal]

if {$bridge_ids_are_equal == "The bridge Ids are equal. "} {
  puts "The switch with mac address of \"[findLowestMac $mac_addresses_list]\" is the Root Bridge. "
}
#
# set largest_BID 0
#
# if {$bridge_ids_are_equal == "The bridge Ids are not equal. "} {
#   set largest_BID [findLargestBid $bridge_IDs_list $largest_BID]
# }
#
# set bridge_IDs_list [replaceValuesEqualToLargestBidWithFoo $bridge_IDs_list $largest_BID]
# puts $bridge_IDs_list
# set not_candidate_root_bridge ""
# puts [defineSwitchesThatCannotBeRootBridges $bridge_IDs_list $not_candidate_root_bridge]


# set mac_addresses_list [replaceNonCandidateSwitchesMac $bridge_IDs_list $mac_addresses_list]
# puts $mac_addresses_list


# set x 0
# set mac_addresses_list [lreplace $mac_addresses_list 1 1 $x]
# set mac_addresses_list [lreplace $mac_addresses_list 3 3 $x]
# puts $mac_addresses_list
