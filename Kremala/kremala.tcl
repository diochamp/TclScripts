#!/usr/bin/tclsh

set string "Sentoni"
set secret_word [split $string {}]
set hyphened_secret_word [split $string {}]
# puts [lreplace $secret_word 1 1 _]
# puts [lreplace $secret_word 1 1 _]
# puts [lreplace $secret_word 2 2 _]

for {set i 1} {$i < [expr [llength $hyphened_secret_word] -1]} {incr i} {
  set hyphened_secret_word [lreplace $hyphened_secret_word $i $i _]
}
# puts $hyphened_secret_word
# puts $secret_word

# proc splitAwordIntoLetters {a_string} {
#   set secret_word [split $a_string {}]
#   # puts [llength $secret_word]
#   if {[llength $secret_word] > 10} {
#     puts "Too many characters"
#     exit
#   } else {
#     return $secret_word
#   }
# }


set number_of_tries 0



while {$number_of_tries < 6} {
  puts "Give me a letter: "
  set exists_counter 0
  gets stdin letter

  for {set i 1} {$i < [expr [llength $secret_word] -1]} {incr i} {
    # set letter_exists False
    if {$letter == [lindex $secret_word $i]} {
      # set letter_exists True
      set hyphened_secret_word [lreplace $hyphened_secret_word $i $i $letter]
      incr exists_counter

    }


  # puts $hyphened_secret_word
  }
  if {$exists_counter >= 1} {
    puts "The letter '$letter' exists $exists_counter times. "
  }
  puts $hyphened_secret_word
}
# proc giveAletter {} {
#   puts "Give a letter: "
#   gets stdin letter
# }

# if {$exists_counter == 1} {
#   puts "The letter '$letter' exists. "
#   continue
# } elseif {$exists_counter > 1} {
#   puts "The letter '$letter' exists $exists_counter times. "
#   }





  # if {$exists_counter > 1} {
  #   puts "The letter '$letter' exists $exists_counter times. "
  # } elseif {$exists_counter == 1} {
  #   puts "The letter '$letter' exists. "
  # }






  # if {$exists_counter == 1} {
  #   puts "The letter '$letter' exists. "
  #   continue
  # } elseif {$exists_counter > 1} {
  #   puts "The letter '$letter' exists $exists_counter times. "
  # }
  #}
