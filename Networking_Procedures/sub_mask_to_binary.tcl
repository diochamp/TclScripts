#!/usr/bin/tclsh

proc subMaskToBinary {sub_mask_dec} {
  source sub_mask_to_binary_procs.tcl

  set tmp_sub_mask_bin_aces [createAces $sub_mask_dec]
  set tmp_sub_mask_bin_zeros [createZeros $sub_mask_dec]
  set sub_mask_bin [concatAcesAndZeros $tmp_sub_mask_bin_aces $tmp_sub_mask_bin_zeros]
  return $sub_mask_bin
}

set sub_mask_bin [subMaskToBinary 16]
exit


# set ip_bits 32
# set sub_mask_dec 24
#
# set tmp_sub_mask_bin {}
#
# for {set i 1} {$i <= $sub_mask_dec} {incr i} {
#   # puts $i
#   lappend tmp_sub_mask_bin 1
# }
#
# set number_of_zeros_to_pad [expr $ip_bits - $sub_mask_dec]
#
# for {set i 0} {$i < $number_of_zeros_to_pad} {incr i} {
#   lappend tmp_sub_mask_bin 0
# }
#
# # puts $tmp_sub_mask_bin
#
# set ace_counter 0
# set zero_counter 0
#
# foreach number $tmp_sub_mask_bin {
#   if {$number == 1} {
#     incr ace_counter
#   } elseif {$number == 0} {
#     incr zero_counter
#   }
# }
#
# puts $ace_counter
# puts $zero_counter
