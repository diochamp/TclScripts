#!/usr/bin/tclsh

proc decimalToBinaryConverter {decimal_number} { ; # Works for decimal numbers from 0 up to 255

  set sum 0 ; # Saves the result of:  set sum [expr [lindex $list $i] + $sum]

  for {set i 62} {$i >= 0} {incr i -1} {
    lappend list [expr int(pow(2,$i))]
    lappend tmplist 0
  }


  for {set i 0} {$i < [llength $list]} {incr i} {
    if {[expr [lindex $list $i] + $sum] <= $decimal_number} {
      set sum [expr [lindex $list $i] + $sum]
      set tmplist [lreplace $tmplist $i $i 1]
    }
  }

  for {set i 0} {$i <= [llength $tmplist]} {incr i} {
    if {[lindex $tmplist $i] == 1} {
      set final_list [lrange $tmplist $i end]
      break
    }
  }

  set binary_number $final_list
  return $binary_number

}

set bin [decimalToBinaryConverter 1000000]
# puts $bin


########################################################################


# set a 10
#
# set list {128 64 32 16 8 4 2 1}
#
# #          0  1  2  3  4 5 6 7
#
# set sum 0
#
#
# # puts $sum
#
# set tmplist {0 0 0 0 0 0 0 0}
#           {        1      }
# set b [expr $a - [lindex $list 4]]
# # puts $b
#
#
#
# if {[lindex $list 0] < $a} {
#   puts "Hello"
# }

# if {[expr [lindex $list 0] + $sum] <= $a} {
#   set sum [expr [lindex $list 0] + $sum]
#   set tmplist [lreplace $tmplist 0 0 1]
# }
#
# if {[expr [lindex $list 1] + $sum] <= $a} {
#   set sum [expr [lindex $list 1] + $sum]
#   set tmplist [lreplace $tmplist 1 1 1]
# }
#
# if {[expr [lindex $list 2] + $sum] <= $a} {
#   set sum [expr [lindex $list 2] + $sum]
#   set tmplist [lreplace $tmplist 2 2 1]
# }
#
# if {[expr [lindex $list 3] + $sum] <= $a} {
#   set sum [expr [lindex $list 3] + $sum]
#   set tmplist [lreplace $tmplist 3 3 1]
# }
#
# if {[expr [lindex $list 4] + $sum] <= $a} {
#   set sum [expr [lindex $list 4] + $sum]
#   set tmplist [lreplace $tmplist 4 4 1]
# }
#
# if {[expr [lindex $list 5] + $sum] <= $a} {
#   set sum [expr [lindex $list 5] + $sum]
#   set tmplist [lreplace $tmplist 5 5 1]
# }
#
#
# if {[expr [lindex $list 6] + $sum] <= $a} {
#   set sum [expr [lindex $list 6] + $sum]
#   set tmplist [lreplace $tmplist 6 6 1]
# }
#
#
# if {[expr [lindex $list 7] + $sum] <= $a} {
#   set sum [expr [lindex $list 7] + $sum]
#   set tmplist [lreplace $tmplist 7 7 1]
# }
#
# puts $sum
# puts $tmplist
# set bin $tmplist
# puts $bin



########################################################################













# puts $sum
# puts $tmplist



# if {[lindex $list 4] <= [expr [lindex $list 4] + $sum]} {
#   set sum [expr [lindex $list 4] + $sum]
#   set tmplist [lreplace $tmplist 4 4 1]
# }




# set tmplist [lreplace $tmplist 0 0 1]
# puts $tmplist


# puts [lreplace {a b c d e} 1 1 x]
# set list {a b c d e}
# set list [lreplace $list 1 1 x]
# puts $list
