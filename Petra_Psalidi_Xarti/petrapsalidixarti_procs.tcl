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

proc createMasterResultsArray {} {
  array set master_results {
    ties {0}
    user {0}
    computer {0}
  }
  return [array get master_results]
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

proc findTheWinner {array_name_Res rounds} {
  upvar $array_name_Res Results

  puts "In round $rounds: "

  if {$Results(user) > $Results(computer)} {
    puts "You win! "
  } elseif {$Results(user) < $Results(computer)} {
    puts "You lose... "
  } else {
    puts "We have a tie! "
  }
}

proc populateMasterResultsArray {array_name_Res array_name_master_results number_of_plays} {
  upvar $array_name_Res Results
  upvar $array_name_master_results master_results

  if {$number_of_plays == 5} {
    set master_results(ties) [expr $master_results(ties) + $Results(ties)]
    set master_results(user) [expr $master_results(user) + $Results(user)]
    set master_results(computer) [expr $master_results(computer) + $Results(computer)]
    parray master_results
  }
}

proc askToPlayAgain {rounds number_of_plays} {
  set play_again False
  if {$rounds == 3} {
    if {$number_of_plays == 5} {
      puts "Do you want to play again?"
      puts "Type 'Yes' if so, or press any key and hit enter to continue. "
      gets stdin answer
      if {$answer == "Yes"} {
        set play_again True
      }
    }
  }
  return $play_again
}

proc reset {array_name_Res} {
  upvar $array_name_Res Results
  upvar 1 rounds rounds
  upvar 1 number_of_plays number_of_plays

  set rounds 1
  set number_of_plays 1
  array set Results [createResultsArray]
}
