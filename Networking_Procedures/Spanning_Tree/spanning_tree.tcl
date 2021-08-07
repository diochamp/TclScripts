#!/usr/bin/tclsh

source spanning_tree_procs.tcl

set tmp_bridge_priorities_list {32768 32768 4096 4096 4096}
set system_extension_id_list {1 1 1 1 1}
set bridge_priorities_list {}

set bridge_priorities_list [createBridgeIds $tmp_bridge_priorities_list $system_extension_id_list]
set bridge_IDs_list $bridge_priorities_list


set mac_addresses_list {1115.2222.3333 1555.2222.3333 7777.7777.7777 4444.4444.4444 3333.3333.3333}
# set bridge_ids_are_equal ""

set bridge_ids_are_equal [checkIfBridgeIdsAreEqual $bridge_IDs_list]

if {$bridge_ids_are_equal == True} {
  puts "The switch with mac address of \"[findLowestMac $mac_addresses_list]\" is the Root Bridge. "
}

set largest_BID 0
set lowest_BID 61441

if {$bridge_ids_are_equal != True} {
  set lowest_BID [findLowestBid $bridge_IDs_list $lowest_BID]
  set lowest_BID_counter [howManyTimesLowestBidExists $bridge_IDs_list $lowest_BID]
  if {$lowest_BID_counter == 1} {
    puts "The switch with bridge Id of \"$lowest_BID\" is the Root Bridge. "
  } elseif {$lowest_BID_counter > 1} {
    set bridge_IDs_list [replaceBidValuesDifferentToLowestBid $bridge_IDs_list $lowest_BID]
    set mac_addresses_list [replaceNonCandidateSwitchesMac $bridge_IDs_list $mac_addresses_list]
    set lowest_MAC [findLowestMac $mac_addresses_list]
    puts "The switch with mac address of \"$lowest_MAC\" is the Root Bridge. "
  }
}

# set lowest_BID_counter 0
# set lowest_BID_counter [howManyTimesLowestBidExists $bridge_IDs_list $lowest_BID]
# puts "The lowest BID exist \"$lowest_BID_counter\" times. "

# if {$lowest_BID_counter == 1} {
#   puts "The switch with bridge Id of \"$lowest_BID\" is the Root Bridge. "
# }

# if {$lowest_BID_counter > 1} {
#   set bridge_IDs_list [replaceBidValuesDifferentToLowestBid $bridge_IDs_list $lowest_BID]
#   set mac_addresses_list [replaceNonCandidateSwitchesMac $bridge_IDs_list $mac_addresses_list]
#   set lowest_MAC [findLowestMac $mac_addresses_list]
#   puts "The switch with mac address of \"$lowest_MAC\" is the Root Bridge. "
# }


# if {$bridge_ids_are_equal == "The bridge Ids are not equal. "} {
#   set largest_BID [findLargestBid $bridge_IDs_list $largest_BID]
# }
#
# set bridge_IDs_list [replaceValuesEqualToLargestBidWithFoo $bridge_IDs_list $largest_BID]
# # puts $bridge_IDs_list
# set not_candidate_root_bridge ""
# # puts [defineSwitchesThatCannotBeRootBridges $bridge_IDs_list $not_candidate_root_bridge]
#
#
# set mac_addresses_list [replaceNonCandidateSwitchesMac $bridge_IDs_list $mac_addresses_list]
# # puts $mac_addresses_list
#
# puts "The switch with mac address of \"[findLowestMac $mac_addresses_list]\" is the Root Bridge. "

# set x 0
# set mac_addresses_list [lreplace $mac_addresses_list 1 1 $x]
# set mac_addresses_list [lreplace $mac_addresses_list 3 3 $x]
# puts $mac_addresses_list
