class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang
        self.letters = letters

    def print(self):
        print(' '.join(self.letters))

    def letters_num(self):
        return len(self.letters)


class EngAlphabet(Alphabet):
    _letters_num = 26  # Private static attribute

    def __init__(self):
        super().__init__('En', "abcdefghijklmnopqrstuvwxyz")

    def is_en_letter(self, letter):
        return letter.lower() in self.letters

    def letters_num(self):
        return EngAlphabet._letters_num  

    @staticmethod
    def example():
        return "The quick brown fox jumps over the lazy dog."


# Tests (main)
if __name__ == "__main__":
    english_alphabet = EngAlphabet()

    english_alphabet.print()
    print(english_alphabet.letters_num())

    print('F belongs to English:', english_alphabet.is_en_letter('F'))
    print('Щ belongs to English:', english_alphabet.is_en_letter('Щ'))

    print("Example text:", EngAlphabet.example())
