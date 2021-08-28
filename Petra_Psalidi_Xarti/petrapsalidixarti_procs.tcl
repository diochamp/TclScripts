#!/usr/bin/tclsh

proc petraPsalidiXartiArray {} {
  array set available_choices {
    1 {petra}
    2 {psalidi}
    3 {xarti}
  }
  return [array get available_choices]
}

proc makeYourChoice {array_name} {
  upvar $array_name available_choices
  puts "Type 1 for \"petra\", 2 for \"psalidi\", or 3 for \"xarti\": "
  gets stdin user_choice
  return $user_choice
}

proc validateUserInput {array_name user_choice} {
  upvar $array_name available_choices
  set user_input False
  set available_choices_list [array names available_choices]

  foreach number $user_choice {
    if {$number in $available_choices_list} {
      set user_input True
    }
  }
  return $user_input

}

proc getArrayValues {array_name} {
  upvar $array_name available_choices

  foreach value [array names available_choices] {
    lappend tmp_list $available_choices($value)
  }
  return $tmp_list
}

proc randomChoice {tmp_list} {
  set random_index [expr {int(rand()*[llength $tmp_list])}]
  set random_choice [lindex $tmp_list $random_index]
  return $random_choice
}