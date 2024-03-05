#!/bin/bash

# Generate the random number
random_number=$(( RANDOM % 100 + 1 ))

# Set the maximum number of attempts
max_attempts=5

for (( attempts=1; attempts <= max_attempts; attempts++ ))
do
  read -p "Guess a number between 1 and 100: " guess

  if [[ $guess -eq $random_number ]]; then
    echo "Congratulations! You guessed the right number."
    exit 0
  elif [[ $guess -lt $random_number ]]; then
    echo "Too low"
  else
    echo "Too high"
  fi
done

echo "Sorry, you've run out of attempts. The correct number was $random_number"
