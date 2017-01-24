// Author: Hunter Ducharme
// Program: This program contains multiple functions as defined in the Assignment 3 handout.
// Inputs: A text file containing all the states.
// Outputs: Concepts from the text file.


// DEFINE HEADER FILES
#include "stdafx.h"
#include <iostream> // console input/output streams
#include <conio.h>  // _getch()
#include <string>   // handling string types
#include <fstream>  // for input/output files
#include <stdlib.h> // exit()
using namespace std;

// DEFINE CONSTANTS
const int SIZE = 58;

// PROTOTYPE FUNCTIONS
void readConcepts(string arrayConcepts[SIZE], int& numberConcepts);                          // Retrieves each concept from the input file and stores them in an array.
char enterLetter();                                                                          // Prompts the user to enter a letter.
void printConcepts(const string arrayConcepts[SIZE], int numberConcepts);                    // Prints out all the concepts.
void printConceptsWithoutSpaces(const string arrayConcepts[SIZE], int numberConcepts);       // Prints concepts that do not contain spaces in the string.
void printConceptsAlphabeticalOrder(string arrayConcepts[SIZE], int numberConcepts);         // Uses an insertion sort algorithm to alphabetize the array then prints the array.
void printConceptsLetter(char letter, const string arrayConcepts[SIZE], int numberConcepts); // Prints concepts starting with the letter the user inputs.

int main()
{
	// Declare variables for storing data.
	string arrayConcepts[SIZE];
	int numberConcepts;
	char letter;

	// Step 0: Output to the user what this program does.
	cout << "This program reads from a text file and follows the following steps:" << endl;
	cout << "1. Retrieves each line of the file." << endl;
	cout << "2. Asks the user to enter a letter." << endl;
	cout << "3. Prints each line of the file." << endl;
	cout << "4. Prints each line of the file that doesn't contain spaces in it." << endl;
	cout << "5. Prints each line of the file in alphabetical order." << endl;
	cout << "5. Prints each line of the file that starts with the letter inputted by the user in step 2." << endl;

	// Step 1: Read the input file and retrieve the concepts.
	readConcepts(arrayConcepts, numberConcepts);

	// Step 2: Prompt the user to enter a letter.
	letter = enterLetter();

	// Step 3: Print each concept.
	printConcepts(arrayConcepts, numberConcepts);

	// Step 4: Print all concepts that do not have spaces.
	printConceptsWithoutSpaces(arrayConcepts, numberConcepts);

	// Step 5: Print the concepts alphabetically.
	printConceptsAlphabeticalOrder(arrayConcepts, numberConcepts);

	// Step 6: Print all concepts that begin with the same letter as the letter inputted by the user in step 2.
	printConceptsLetter(letter, arrayConcepts, numberConcepts);

	// Wait for a character to exit the console.
	cout << "\n\nPress any button to exit the console... ";
	_getch();

    return 0;
}

void readConcepts(string arrayConcepts[SIZE], int& numberConcepts)
{
	// Declare count variable and input file.
	int count = 0;
	ifstream inputFile("list.txt");

	// Tell user the function is starting to read the file.
	cout << "\n\n\nReading concepts... ";

	// Throw error if input file can not be read.
	if (inputFile.bad())
	{
		cout << "\n\nERROR: could not open input file. Aborting program.";
		exit(EXIT_FAILURE);
	}

	// Get all the concepts in the file and put them into arrayConcepts.
	while (inputFile) {
		string concept;

		// Get the current line in the file, store it into arrayConcepts, and increment count.
		getline(inputFile, concept);
		arrayConcepts[count] = concept;
		count++;
	}

	// Close the input file.
	inputFile.close();

	// The total number of concepts is equal to the final count number.
	numberConcepts = count;

	// Tell user this function was successful.
	cout << "SUCCESSFUL" << endl;
}

char enterLetter()
{
	// Define variable for storing character input.
	char letter;
	
	// While the input is not a letter, prompt the user to input a letter.
	do {
		cout << "\nEnter a letter from A to Z (uppercase or lowercase): ";
		cin >> letter;
		cout << endl;
	} while ((letter < 'a' && letter < 'z') || (letter > 'A' && letter < 'Z'));

	// Return the uppercase version of the letter.
	return toupper(letter);
}

void printConcepts(const string arrayConcepts[SIZE], int numberConcepts)
{
	// Define iteration variable.
	int k;

	// Print all elements in arrayConcepts.
	cout << "\n\nPrinting all concepts..." << endl << endl;
	for (k = 0; k < numberConcepts; k++) {
		cout << arrayConcepts[k] << endl;
	}
}

void printConceptsWithoutSpaces(const string arrayConcepts[SIZE], int numberConcepts)
{
	// Define iteration variable.
	int k;

	// Print all elements in arrayConcepts that do not have spaces.
	cout << "\n\nPrinting all concepts that don't contain spaces..." << endl << endl;
	for (k = 0; k < numberConcepts; k++) {
		string concept = arrayConcepts[k];

		// Print concepts that have don't have a space in them.
		if (!(concept.find(" ") < 20))
			cout << concept << endl;
	}
}

void printConceptsAlphabeticalOrder(string arrayConcepts[SIZE], int numberConcepts)
{
	// Define iteration variables.
	int k;

	//** INSERTION SORT ALGORITHM **//
	// Iterate through each element of the array.
	for (k = 1; k < numberConcepts; k++) {
		int j = k;                                // Define second iteration variable.
		string currentElement = arrayConcepts[k]; // Define variable to store the current element.

		// While the element to the left of currentElement is greater, swap the two elements. 
		while ((j > 0) && (arrayConcepts[j] < arrayConcepts[j - 1])) {
			string temp = arrayConcepts[j];          // Temporarily store the jth element
			arrayConcepts[j] = arrayConcepts[j - 1]; // Move the element at index j-1 one position up to index j.
			arrayConcepts[j - 1] = temp;             // Move the jth element one poisition down to index j-1.
			j--;                                     // Decrement j variable.
		}
	} //** END NSERTION SORT ALGORITHM **//

	// Print out the elements in alphabetical order.
	cout << "\n\nPrinting the concepts in alphabetical order..." << endl << endl;
	for (int i = 0; i < numberConcepts; i++) {
		cout << arrayConcepts[i] << endl;
	}
}

void printConceptsLetter(char letter, const string arrayConcepts[SIZE], int numberConcepts)
{
	// Tell the user the program is printing the elements that start with the same letter as the user's input.
	cout << "\n\nPrinting the concepts that begin with the letter '" << letter << "'..." << endl << endl;

	// Iterate through each element of the array.
	for (int k = 0; k < numberConcepts; k++) {

		// If the first letter of the concept matches the input letter, print the concept.
		if (arrayConcepts[k][0] == letter)
			cout << arrayConcepts[k] << endl;
	}
}