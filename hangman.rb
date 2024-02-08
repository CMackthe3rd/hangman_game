require 'net/http'
require 'json'
require 'pry'

class Hangman
  DEFAULT_WORDS = [
  'ruby', 'python', 'javascript', 'java', 'html', 'css',
  'hangman', 'programming', 'computer', 'developer', 'coding',
  'challenge', 'solution', 'algorithm', 'keyboard', 'mouse',
  'function', 'variable', 'array', 'string', 'boolean',
  'condition', 'loop', 'framework', 'database', 'network',
  'authentication', 'security', 'design', 'interface'
]


  def initialize
    set_up_game
  end

  def play
    puts display_rules.stripgit 
    loop do
      disset_up_game_state
      guess = get_user_guess

      update_game_state(guess)

      break if game_over?
    end
    new_game?
  end

  private

  def choose_word_from_api
    uri = URI('https://wordsapiv1.p.rapidapi.com/words/?random=true')
    headers = {
      'X-RapidAPI-Host' => 'wordsapiv1.p.rapidapi.com',
      'X-RapidAPI-Key' => 'your_api_key_here'
    }

    begin
      loop do
      response = Net::HTTP.get(uri, headers)
      parsed_response = JSON.parse(response)
      raise StandardError, "Unexpected response format" unless parsed_response.key?('word')
      chosen_word = parsed_response['word']
      return chosen_word unless chosen_word.include?(' ')
      end
    rescue StandardError => e
      puts "Error fetching word from API: #{e.message}"
      puts "Using a default word."
      # Provide a default word or exit the game gracefully
      @default_word  # Default word
    end
  end
  

  def disset_up_game_state
    puts "Current State: #{display_word}"
    puts "Incorrect Guesses: #{@incorrect_guess.length}/#{@max_attempts}"
  end

  def display_word
    @word_to_guess.chars.map { |letter| @guessed_letters.include?(letter) ? letter : '_' }.join(' ')
  end

  def get_user_guess
    loop do
      puts "Enter a letter: "
      guess = gets.chomp.downcase

      # Validate input
      return guess if valid_guess?(guess)
      puts "Invalid input. Please enter a single letter that you haven't guessed before."
    end
  end

  def valid_guess?(guess)
    guess.match?(/[a-z]/) && guess.length == 1 && !@guessed_letters.include?(guess) && !@incorrect_guess.include?(guess)
  end

  def update_game_state(guess)
    if @word_to_guess.include?(guess)
      @guessed_letters << guess
      puts "Correct guess!"
    else
      @incorrect_guess << guess
      puts "Incorrect guess!"
    end
  end

  def game_over?
    if @word_to_guess.chars.all? { |letter| @guessed_letters.include?(letter) }
      puts "Congratulations! You've won. The word was '#{@word_to_guess}'."
      return true
    elsif @incorrect_guess.size >= @max_attempts
      puts "Sorry, you've lost. The word was #{@word_to_guess}."
      return true
    end

    false
  end

  def set_up_game
    @word_to_guess = choose_word_from_api
    @guessed_letters = []
    @max_attempts = 7
    @incorrect_guess = []
    @default_word = DEFAULT_WORDS.sample
  end

  def new_game?
    puts "Would you like to play again? (y/n)"
    answer = gets.chomp.downcase

    if answer == 'y'
      set_up_game
      play
    elsif answer == 'n'
      puts "Thanks for playing Hangman!"
      exit
    else
      puts "Invalid input. Please choose y/n."
    end
  end

  def display_rules
    <<-msg
      The object of the game is to guess the secret word before the maximum number of guesses is reached. The Player will select one letter at a time to narrow the word down.
    msg
  end
end

# Create an instance of the Hangman class and start the game
hangman_game = Hangman.new
hangman_game.play
