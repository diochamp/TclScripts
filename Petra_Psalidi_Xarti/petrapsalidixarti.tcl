#!/usr/bin/tclsh

source petrapsalidixarti_procs.tcl

array set available_choices [petraPsalidiXartiArray]

set number_of_plays 1

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

  set Rules(petra) {psalidi}
  set Rules(psalidi) {xarti}
  set Rules(xarti) {petra}

  if {$available_choices($user_choice) == $computer_choice} {
    puts "Isopalia. "
  } elseif {$Rules($available_choices($user_choice)) == $computer_choice} {
    puts "You win. "
  } else {
    puts "You lose. "
  }

  # puts $Rules($available_choices($user_choice))


  incr number_of_plays
}
