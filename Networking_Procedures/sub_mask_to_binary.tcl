#!/usr/bin/tclsh

proc subMaskToBinary {sub_mask_dec} {
  source sub_mask_to_binary_procs.tcl

  set tmp_sub_mask_bin_aces [createAces $sub_mask_dec]
  set tmp_sub_mask_bin_zeros [createZeros $sub_mask_dec]
  set sub_mask_bin [concatAcesAndZeros $tmp_sub_mask_bin_aces $tmp_sub_mask_bin_zeros]
  return $sub_mask_bin
}
