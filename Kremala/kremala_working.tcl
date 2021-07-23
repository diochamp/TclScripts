#!/usr/bin/tclsh

source Kremala_procs/kremala_procs.tcl

array set kremala [kremalaArray]
# parray kremala

set categories [array names kremala]

while True {

  set chosen_category [chooseCategory $categories]
  if {![chosenCategoryValidityCheck $chosen_category $categories]} { ; # puts $kremala($chosen_category)
    puts "The category you chose does not exist, please try again.\n "
    continue
  } else {
    break
  }
}

set number_of_tries 0

set given_letters_list {}

set candidate_words [candidateWords [array get kremala] $chosen_category]

set chosen_word [randomChosenWord $candidate_words]

set secret_word [splitAwordIntoLetters $chosen_word]

set hyphened_secret_word [createHyphenedSecretWordFromString $secret_word]
puts $hyphened_secret_word

set number_of_tries 0

while {$number_of_tries <= 6} {
  set exists_counter 0

  set letter [giveAletter]

  if {[isLetterUsed $letter $given_letters_list]} {
    puts "You have used this letter. Please give another. "
    continue
  } else {
    lappend given_letters_list $letter
  }

  puts "You have used the letters \{$given_letters_list\}"

  if {[letterExists $letter]} {
    puts "The letter '$letter' exists $exists_counter times. "
  } else {
    puts "The letter '$letter' does not exist. "
    incr number_of_tries
  }

  remainingNumberOfTries $number_of_tries
  puts "$hyphened_secret_word\n##########################\n\n"

  set last_try [lastTry $number_of_tries $secret_word $hyphened_secret_word]

  if {$last_try == False} {
    puts "You lose... The word was [join '$secret_word' ""]. "
    if {[playAgain]} {
    setup
    puts $hyphened_secret_word
    continue
  } else {
    exit
  }

  }

  if {[checksIfYouWin $hyphened_secret_word $secret_word]} {
    if {[playAgain]} {
      setup
      # reset
      puts $hyphened_secret_word
      # setup $number_of_tries $words $chosen_word $secret_word $hyphened_secret_word $given_letters_list
      continue
  } else {
    exit
    }
  }




}





# puts [availableCategories [array names Kremala]]

# while {number_of_tries <= 6} {
#   set exists_counter 0
# }


































# for {set i 0} {$i < [llength $array_get_kremala]} {incr i} {
#   if {[expr $i % 2 != 0]} {
#     set words $kremala($chosen_category)
#   }
# }
# puts $words

# set words [getWords words.txt]
# set chosen_word [randomChosenWord $words]
#
# set secret_word [splitAwordIntoLetters $chosen_word]
# set hyphened_secret_word [createHyphenedSecretWordFromString $secret_word]
# puts $hyphened_secret_word
# set given_letters_list {}
# set a [array get kremala]
# puts $a
# puts [llength $a]

# for {set i 0} {$i < [llength [array get kremala]]} {incr i} {
#   # puts "$i -> [lindex [array get kremala]] $i]"
#   if {[expr $i % 2 != 0]} {
#       # puts [lindex [array get kremala] $i]
#       puts $kremala($i)
#   }
# }

# foreach {name} [array names kremala] {
#   if {$choise == $name} {
#     puts $choise
#     puts $name
#     # puts $kremala($choise)
#     set list $kremala($choise)
#     puts $list
#   }
# }
