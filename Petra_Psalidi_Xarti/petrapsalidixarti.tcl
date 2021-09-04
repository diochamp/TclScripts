#!/usr/bin/tclsh

source petrapsalidixarti_procs.tcl

array set available_choices [petraPsalidiXartiArray]

set rounds 1

set number_of_plays 1

array set Rules [createRulesArray]

array set Results [createResultsArray]

array set master_results [createMasterResultsArray]

while {$rounds <=3} {

  puts "Round: $rounds"

  while {$number_of_plays <= 5} {
    set user_choice [makeYourChoice available_choices]

    while True {
      if {[validateUserInput available_choices $user_choice] == True} {
        break
      } else {
        puts "Your choice is invalid, try again: "
        set user_choice [makeYourChoice available_choices]
      }
    }

    puts "You chose \"$available_choices($user_choice)\""

    set tmp_list [getArrayValues available_choices]

    set computer_choice [randomChoice $tmp_list]
    puts "Computer chose \"$computer_choice\""

    checkWhoWinsPerPlay available_choices Rules Results $user_choice $computer_choice $number_of_plays

    parray Results
    puts "\n"

    populateMasterResultsArray Results master_results $number_of_plays

    if {$number_of_plays == 5} {
      findTheWinner Results $rounds
      if {[askToPlayAgain $rounds $number_of_plays]} {
        reset Results
        break
      }
      incr rounds
      set number_of_plays 1
      array set Results [createResultsArray]
      break
    }

    incr number_of_plays
  }

}
