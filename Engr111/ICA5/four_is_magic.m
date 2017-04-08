function [ magicalProperty ] = four_is_magic( n )
%FOUR_IS_MAGIC Prints says a number is magic if the amount of letters in
%the number is equal to the value of the number.

english = Num2Word(n);
wordSplit = strsplit(english);
characters = zeros(0);
for i = 1:length(wordSplit)
    word = char(wordSplit(i));
    for k = 1:length(word)
        characters = [characters word(k)];
    end
end

if length(characters) == n
    fprintf('%s is magic!\n', english);
    return;
else
    fprintf('%s is %0.0f\n', english, length(characters));
    n = length(characters);
    four_is_magic(n);
end
end

