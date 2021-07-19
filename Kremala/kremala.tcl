#!/usr/bin/tclsh

source Kremala_procs/kremala_procs.tcl

set number_of_tries 0

set words [getWords words.txt]
set chosen_word [randomChosenWord $words]

set secret_word [splitAwordIntoLetters $chosen_word]
set hyphened_secret_word [createHyphenedSecretWordFromString $secret_word]
# puts $secret_word\n
puts $hyphened_secret_word
set given_letters_list {}



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
    puts "You lose... The word was $secret_word. "
    if {[playAgain]} {
      reset
      continue
    } else {
      exit
    }
  }





  # if {[checksIfYouWin $hyphened_secret_word $secret_word]} {
  #   if {[playAgain]} {
  #     reset
  #     continue
  # } else {
  #   exit
  #   }
  # }



}
