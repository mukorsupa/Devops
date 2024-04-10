import random

def guess_the_number():
  """
  This function generates a random number between 1 and 100 and plays a guessing game with the user.
  """
  # Generate random number
  secret_number = random.randint(1, 100)
  # Initialize guess count
  guess_count = 0

  while guess_count < 5:
    # Get user guess
    try:
      guess = int(input("Guess a number between 1 and 100: "))
    except ValueError:
      print("Invalid input. Please enter a number.")
      continue

    # Check guess
    guess_count += 1
    if guess == secret_number:
      print("Congratulations! You guessed the right number.")
      break
    elif guess < secret_number:
      print("Too low, try again.")
    else:
      print("Too high, try again.")

  if guess_count == 5:
    print(f"Sorry, you've run out of attempts. The correct number was {secret_number}")

# Start the game
guess_the_number()
