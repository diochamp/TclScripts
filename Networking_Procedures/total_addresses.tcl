#!/usr/bin/tclsh

source decimal_to_binary.tcl

# set a 11

# puts [format %-08s $a]
# puts [format %08i $a]


if 0 {
  set b [join [decimalToBinaryConverter 127] ""]
  puts $b
  set b [join $b ""]
  set b [format %08i $b]
  puts $b
}

if 0 {
  set tmp 2
  for {set i 0} {$i < 63} {incr i} {
    set a [expr 2*$tmp]
    puts $a
    set tmp $a
  }
}

# set a [decimalToBinaryConverter 366]

if 0 {
  set tmp 8
  set tmp_total 0
  for {set i 0} {$i < 63} {incr i} {
    set a [expr 8+$tmp]
    incr tmp 8
    puts $a
    if {$i >= 10} {
      exit
    }
  }
}

set a_list {}
set stath 8
set tmp 0
set tmp_total 0
for {set i 0} {$i < 63} {incr i} {
  set tmp [expr $tmp + $stath]
  lappend a_list $tmp
  # puts $tmp

}
puts $a_list
set a [decimalToBinaryConverter 269]
puts $a
puts "llength : [llength $a]"

if {[llength $a] ni $a_list} {
  puts "hello"
  set a [join $a ""]
  # puts $a
  set a [split $a ""]
#   set a [format %08i $a]
#   puts $a
#   set a [split $a ""]
#   puts $a
}

set smallest 0
foreach el $a_list {
  if {$el < [llength $a]} {
    set smallest $el
  }
}
puts $smallest

set which_index [lsearch $a_list $smallest]
puts "Which index in 'a_list': $which_index"

set next_index [expr $which_index + 1]
puts $next_index

# puts [lindex $a_list $next_index]

set zeros_to_pad [expr [lindex $a_list $next_index] - [llength $a]]
puts "Zeros to pad: $zeros_to_pad"

set total_digits [expr [llength $a] + $zeros_to_pad]
puts "total digits: $total_digits"

set a [join $a ""]
set b [format %0$total_digits\i $a]
set b [split $b ""]
puts $b
puts [llength $b]
