#!/usr/bin/tclsh

# Works on par with kremala_v2.tcl

#### kremalaArray ####
# Creates the array that contains the categories (keys) from which the user
# has to choose. The values are the candidate words.

proc kremalaArray {} {
  array set kremala {
    Teams {Olimpiakos Panathinaikos Aek Mpaok}
    Countries {Greece Italy Spain Germany}
    Covid {Vaccine Lockdown Mask Socialdistance}
    Spray-19 {Pseka Psekasmenos Psekastiras Psekastiko}
  }
  # parray kremala
  return [array get kremala]
}

proc initiate {categories} {
  upvar 1 chosen_category chosen_category
  while True {

    set chosen_category [chooseCategory $categories]
    if {![chosenCategoryValidityCheck $chosen_category $categories]} { ; # puts $kremala($chosen_category)
      puts "The category you chose does not exist, please try again.\n "
      continue
    } else {
      puts "Ok"
      break
    }
  }
  # return
}

proc chooseCategory {categories} { ; # Promts the user to choose one of the array categories (keys).
  # upvar 1 kremala kremala
  puts "Choose one of the following categories:\n\n     \{$categories\}\n"
  gets stdin chosen_category
  puts \n
  return $chosen_category
  # parray kremala
  # return [array names kremala]
}

proc chosenCategoryValidityCheck {chosen_category categories} { ; # Validates the user choise.
  set validity_check_flag False
  foreach category $categories {
    if {$category == $chosen_category} {
      set validity_check_flag True
    }
  }
  return $validity_check_flag
}

proc setup {chosen_category} {

  upvar 1 kremala kremala
  # upvar 1 chosen_category chosen_category
  upvar 1 given_letters_list given_letters_list
  upvar 1 number_of_tries number_of_tries
  # upvar 1 candidate_words candidate_words
  # upvar 1 words words
  upvar 1 chosen_word chosen_word
  upvar 1 secret_word secret_word
  upvar 1 hyphened_secret_word hyphened_secret_word
  upvar 1 number_of_tries number_of_tries

  set number_of_tries 0

  set given_letters_list {}

  set candidate_words [candidateWords [array get kremala] $chosen_category]
  # set words [getWords words.txt]
  set chosen_word [randomChosenWord $candidate_words]

  set secret_word [splitAwordIntoLetters $chosen_word]

  set hyphened_secret_word [createHyphenedSecretWordFromString $secret_word]
  # puts $secret_word\n
  puts $hyphened_secret_word


}

proc candidateWords {array_get_kremala chosen_category} { ; # Returns the words belonging to the category the user chose.

  upvar 1 kremala kremala
  # upvar 1 chosen_category chosen_category
  for {set i 0} {$i < [llength [array get kremala]]} {incr i} {
    if {[expr $i % 2 != 0]} {
      set candidate_words $kremala($chosen_category)
    }
  }
  return $candidate_words
}

proc randomChosenWord {candidate_words} { ; # Randomly choses a word from the previously selected category.
  set random_index [expr {int(rand()*[llength $candidate_words])}]
  set chosen_word [lindex $candidate_words $random_index]
  return $chosen_word
}

proc splitAwordIntoLetters {chosen_word} { ; # Transform a word into "W o r d" form instead of "Word"
  set secret_word [split $chosen_word {}]
  # puts [llength $secret_word]
  # if {[llength $secret_word] > 10} {
  #   puts "Too many characters"
  #   exit
  # } else {
    return $secret_word
  }
}

proc createHyphenedSecretWordFromString {secret_word} { ; # Transforms a word into "W _ _ d" form.
  set hyphened_secret_word "$secret_word"
  for {set i 1} {$i < [expr [llength $secret_word] -1]} {incr i} {
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
  # upvar 1 given_letters_list given_letters_list
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
  # expr 6 - $number_of_tries
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
  puts "Do you want to play again? Type 'Yes' if so. "
  gets stdin word
  if {$word == "Yes"} {
    set flag True
  }
  return $flag
}

proc tryAgainUsingTheLastRandomlyChosenWord {} {
  set flag False
  puts "If you want to try again using the same word type 'Yes', else press any key to continue. "
  gets stdin word
  if {$word == "Yes"} {
    set flag True
  }
  return $flag
}

proc reset {chosen_category} {

  upvar 1 kremala kremala
  upvar 1 given_letters_list given_letters_list
  upvar 1 number_of_tries number_of_tries
  upvar 1 chosen_word chosen_word
  upvar 1 secret_word secret_word
  upvar 1 hyphened_secret_word hyphened_secret_word
  upvar 1 number_of_tries number_of_tries

  set number_of_tries 0

  set given_letters_list {}

  set secret_word [splitAwordIntoLetters $chosen_word]

  set hyphened_secret_word [createHyphenedSecretWordFromString $secret_word]

  puts $hyphened_secret_word

}
