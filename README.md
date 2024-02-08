# Hangman Game

This is a command-line Hangman game implemented in Ruby. The game randomly selects a word from the Words Rapid API for the player to guess. The player has to guess one letter at a time to reveal the word. The player wins if they successfully guess all the letters in the word before making too many incorrect guesses.

## Features

- Randomly selects a word from the Words Rapid API for the player to guess.
- Allows the player to guess one letter at a time.
- Tracks the number of incorrect guesses made by the player.
- Notifies the player if they win or lose the game.

## Prerequisites

- Ruby installed on your machine

## How to Play

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your-username/hangman-game.git
   ```

2. Navigate to the project directory:

   ```bash
   cd hangman-game
   ```

3. Install dependencies:

   ```bash
   gem install net-http
   gem install json
   ```

4. Run the game:

   ```bash
   ruby hangman.rb
   ```

5. Follow the instructions displayed in the console to play the game.

## Customization

You can customize the game by modifying the `DEFAULT_WORDS` array in the `Hangman` class. However, if you prefer to use the Words Rapid API for word selection, you can keep the default configuration to fetch words from the API.

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please fork the repository and create a pull request with your changes. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
