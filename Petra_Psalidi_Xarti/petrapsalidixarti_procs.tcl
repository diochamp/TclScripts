#!/usr/bin/tclsh

proc makeYourChoice {available_choices} {
  puts "Choose one of the following:\n\"$available_choices\""
  gets stdin user_choice
  return $user_choice
}

proc randomChoice {available_choices} {
  set random_index [expr {int(rand()*[llength $available_choices])}]
  set random_choice [lindex $available_choices $random_index]
  return $random_choice
}
