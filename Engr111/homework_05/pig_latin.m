function [ translated ] = pig_latin( string )
%PIG_LATIN takes a string and converts it to Pig Latin.

% Constants
VOWELS = ['a','e','i','o','u'];

% Variables
words = strsplit(string);
translatedWords = [];

% Processing
for word = words
    lettersInWord = length(word);
    characters = strsplit(char(word), '.');
    disp(word(1, 1));
end

end

