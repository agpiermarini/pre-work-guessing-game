# The user is greeted and given instructions at startup
puts """

                      Welcome to the Number Guessing Game!


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++++++++++++++++++++++++++++++++ INSTRUCTIONS +++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

I have generated a random number between 1 and 100! Your objective is to guess
the number.

Submit guesses by typing numbers and then pressing enter! You can request a hint
by typing either '(h)' or '(h)int'. If all else fails and you would like the
number to be revealed, respond with '(c)' or '(c)heat'.

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

"""

# Method to ensure that user has a) entered an integer in range, b) requested to cheat, or c) requested a hint
def audit(input)
    if input.to_i >= 1 && input.to_i <= 100 ||
    input == "(c)" || input == "(c)heat" ||
    input == "(h)int" || input == "(h)"
        return true
    else
        return false
    end
end


def run
    # Generates random number between 1 and 100; sets to string class, as the user_guess defaults to strings
    # in order to allow code to qualify both the integer inputs and cheat/hint commands. Random_Number is converted
    # to integer when necessary, i.e. for numerical comparisons
    random_number = rand(1..100).to_s
    guesses = [] # Creates array to store guesses to later be displayed to user

    #puts random_number    # FOR TESTING--Comment out in final

    # Various prompts and repeated phrases set to variables for ease of editing in future
    prompt = " > "
    first_guess = "\nWhat is your first guess?" + prompt
    next_guess = "\nWhat is your next guess?" + prompt
    bad_input = "Oops! You must return a number, and the number needs to be between 0 and 100."
    incorrect_guess = "Guess again!"
    guess_greater_than = "\nYour guess is greater than the random number that I generated. "
    guess_less_than = "\nYour guess is less than the random number that I generated. "
    correct_guess = "\nCongratulations, you guessed the correct number!"
    reminder = "\nYou have already guessed the following numbers:"
    divider = "+" * 80

    puts first_guess # Prints first request for input

    # Loop that continuously requests input and provides feedback until user either guesses
    # the correct number or enters the cheat/hint commands--each of which breaks the loop
    loop do
        user_guess = gets.chomp # Prompts user for input
        # Loops user through gets.chomp until they enter either an integer in range, cheat commands, or hint commands
        until audit(user_guess) == true
            puts divider, bad_input, divider, next_guess
            user_guess = gets.chomp
            audit(user_guess)
        end
        # User guesses correct number--displays message and breaks loop/ends game
        if user_guess == random_number
            puts correct_guess
            break
        # User inputs cheat commands--displays the number and breaks loop/ends game
        elsif user_guess == "(c)" || user_guess == "(c)heat"
            puts "Giving up already? The random number is #{random_number}!"
            break
        # User enters hint commands--tells user whether number is 1..50 or 51..100
        elsif user_guess == "(h)" || user_guess == "(h)int"
            puts "Hint: The random number is between 51 and 100." if random_number.to_i >= 51
            puts "Hint: The random number is between 1 and 50." if random_number.to_i <= 50
            puts next_guess
        # User's guess is greater than random_number, informs user and requests another guess
        # Converts to integer class for numerical comparison
        elsif user_guess.to_i > random_number.to_i
            guesses << user_guess # Adds incorrect guesses to "guesses" array
            print guess_greater_than + incorrect_guess
            puts reminder, guesses.uniq, '', divider, next_guess # Reminds user which numbers they have guessed, then requests next guess
        # User's guess is less than random_number, informs user and requests another guess
        # Converts to integer class for numerical comparison
        elsif user_guess.to_i < random_number.to_i
            guesses << user_guess
            print guess_less_than + incorrect_guess
            puts reminder, guesses.uniq, '', divider, next_guess
        end
    end
end

# Runs the game
puts run
