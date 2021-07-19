#!/usr/bin/tclsh

proc getWords {fileName} {
  set fid [open $fileName]
  set words_string [read $fid]
  close $fid
  set words [split $words_string "\n"]
  return $words
}

proc randomChosenWord {words} {
  set random_index [expr {int(rand()*[llength $words])}]
  set chosen_word [lindex $words $random_index]
  return $chosen_word
}

proc splitAwordIntoLetters {a_string} {
  set secret_word [split $a_string {}]
  # puts [llength $secret_word]
  # if {[llength $secret_word] > 10} {
  #   puts "Too many characters"
  #   exit
  # } else {
    return $secret_word
  }
}


proc createHyphenedSecretWordFromString {a_string} {
  set hyphened_secret_word "$a_string"
  for {set i 1} {$i < [expr [llength $a_string] -1]} {incr i} {
    set hyphened_secret_word [lreplace $hyphened_secret_word $i $i _]
  }
  return $hyphened_secret_word
}


proc giveAletter {} {
  puts "Give a letter: "
  gets stdin letter
  puts ""
  return $letter
}

proc isLetterUsed {letter given_letters_list} { ; # Checks if the user has given a letter more than one times.
  set used_twice False

  if {$letter in $given_letters_list} {
    set used_twice True
  }
  return $used_twice
}

proc letterExists {letter} {
  upvar 1 exists_counter exists_counter
  upvar 1 secret_word secret_word
  upvar 1 hyphened_secret_word hyphened_secret_word
  set exists False

  for {set i 1} {$i < [expr [llength $secret_word] -1]} {incr i} {
    if {$letter == [lindex $secret_word $i]} {
      set hyphened_secret_word [lreplace $hyphened_secret_word $i $i $letter]
      incr exists_counter
      set exists True
    }
  }
  return $exists
}

proc remainingNumberOfTries {number_of_tries} {
  puts "You have [expr 6 - $number_of_tries] tries yet. "
}

proc lastTry {number_of_tries secret_word hyphened_secret_word} {
  # upvar 1 hyphened_secret_word hyphened_secret_word
  # upvar 1 secret_word secret_word
  set last_try_flag True
  if {$number_of_tries == 6} {
    if {![checksIfYouWin $hyphened_secret_word $secret_word]} {
      set last_try_flag False
    }
  }
  return $last_try_flag
}

proc checksIfYouWin {hyphened_secret_word secret_word} {
  set win_check False
  if {$hyphened_secret_word == $secret_word} {
    set win_check True
    puts "Congratulations! You win! "
  }
  return $win_check
}

proc playAgain {} {
  set flag False
  puts "Do you want to play again? Type 'Yes' is so. "
  gets stdin word
  if {$word == "Yes"} {
    set flag True
  }
  return $flag
}

proc setup {} {

  upvar 1 given_letters_list given_letters_list
  upvar 1 number_of_tries number_of_tries
  upvar 1 words words
  upvar 1 chosen_word chosen_word
  upvar 1 secret_word secret_word
  upvar 1 hyphened_secret_word hyphened_secret_word
  upvar 1 number_of_tries number_of_tries

  set number_of_tries 0

  set words [getWords words.txt]
  set chosen_word [randomChosenWord $words]

  set secret_word [splitAwordIntoLetters $chosen_word]
  set hyphened_secret_word [createHyphenedSecretWordFromString $secret_word]
  set given_letters_list {}

}

proc reset {} {
  upvar 1 given_letters_list given_letters_list
  upvar 1 number_of_tries number_of_tries
  upvar 1 words words
  upvar 1 chosen_word chosen_word
  upvar 1 secret_word secret_word
  upvar 1 hyphened_secret_word hyphened_secret_word
  upvar 1 number_of_tries number_of_tries

  set number_of_tries 0

  set words [getWords words.txt]
  set chosen_word [randomChosenWord $words]

  set secret_word [splitAwordIntoLetters $chosen_word]
  set hyphened_secret_word [createHyphenedSecretWordFromString $secret_word]
  set given_letters_list {}

}
