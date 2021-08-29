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

proc createRulesArray {} {
  array set Rules {
    petra {psalidi}
    psalidi {xarti}
    xarti {petra}
  }
  return [array get Rules]
}

proc createResultsArray {} {
  array set Results {
    ties {0}
    user {0}
    computer {0}
  }
  return [array get Results]
}

proc checkWhoWinsPerPlay {array_name_av_ch array_name_Rul array_name_Res user_choice computer_choice number_of_plays} {
  upvar $array_name_av_ch available_choices
  upvar $array_name_Rul Rules
  upvar $array_name_Res Results

  puts "In play $number_of_plays"

  if {$available_choices($user_choice) == $computer_choice} {
    puts "We have a tie. "
    incr Results(ties)
  } elseif {$Rules($available_choices($user_choice)) == $computer_choice} {
    puts "You win. "
    incr Results(user)
  } else {
    puts "You lose. "
    incr Results(computer)
  }
}
