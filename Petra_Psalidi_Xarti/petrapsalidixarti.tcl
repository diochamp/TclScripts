#!/usr/bin/tclsh

source petrapsalidixarti_procs.tcl

set available_choices {petra psalidi xarti}

set user_choice [makeYourChoice $available_choices]

set computer_choice [randomChoice $available_choices]
puts "Computer chose \"$computer_choice\""
