#!/usr/bin/tclsh

proc createAces {sub_mask_dec} {
  set tmp_sub_mask_bin_aces {}

  for {set i 1} {$i <= $sub_mask_dec} {incr i} {
    lappend tmp_sub_mask_bin_aces 1
  }
  return $tmp_sub_mask_bin_aces
}

proc createZeros {sub_mask_dec} {
  set tmp_sub_mask_bin_zeros {}
  set ip_bits 32
  set number_of_zeros_to_pad [expr $ip_bits - $sub_mask_dec]

  for {set i 0} {$i < $number_of_zeros_to_pad} {incr i} {
    lappend tmp_sub_mask_bin_zeros 0
  }
  return $tmp_sub_mask_bin_zeros
}

proc concatAcesAndZeros {tmp_sub_mask_bin_aces tmp_sub_mask_bin_zeros} {
  set sub_mask_bin [concat $tmp_sub_mask_bin_aces $tmp_sub_mask_bin_zeros]
  return $sub_mask_bin
}

proc verifySubMaskBits {sub_mask_bin} {
  set flag True
  if {[llength $sub_mask_bin] != 32} {
    set $flag False
  }
  return $flag
}
