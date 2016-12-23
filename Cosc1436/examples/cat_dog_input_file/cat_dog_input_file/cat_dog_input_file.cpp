// Author: Hunter Ducharme
// Program: This program reads names and numbers from a formatted input file, 
//          computes the sum and average of the numbers, and finds the largest and smallest numbers.
// Input: Input file containing formatted names and numbers.
// Output: The data and statistics in a formatted table.

#include "stdafx.h"
#include <iostream> // for cin and cout
#include <iomanip>  // for input/output manipulators
#include <conio.h>  // for _getch()
#include <string>   // to input strings
#include <fstream>  // for input/output files

using namespace std;


int main()
{

	// Define variables to manipulate data.
	string line;
	int sum = 0, average = 0, maxNumber = 0, minNumber = 100000, count = -1;

	// Define file stream variables.
	ifstream inputFile("textFile.txt");
	ofstream outputFile("outputFile.txt");

	if (inputFile.bad())
	{
		cout << "ERROR: could not open the input file.";
		exit;
	}
	else
	{
		cout << "Successfully loaded the input file, proceeding with program.\n" << endl;
	}

	// OUTPUT table header
	cout << setw(8) << left << "Name" << '|' << setw(7) << right << "Number" << endl;
	cout << setfill('-');
	cout << setw(7) << left << "-" << "-+-" << setw(6) << left << '-' << endl;             // OUTPUT divider between data and statistics
	cout << setfill(' ');

	// Iterate over each line of the file.
	while (inputFile)
	{
		string name;
		int number;

		count++;
		inputFile >> name;

		if (inputFile.eof())
			break;

		inputFile >> number;

		// OUTPUT table rows
		cout << setw(8) << left << name << '|' << setw(7) << right << number << endl;

		// COMPUTE sum, largest number, and smallest number
		sum = sum + number;
		(number > maxNumber) ? maxNumber = number : 0; // Find largest number.
		(number < minNumber) ? minNumber = number : 0; // Find smallest number.
	}

	// COMPUTE average
	average = sum / count;

	// OUTPUT statistics into the table.
	if (count != 0)
	{
		cout << setfill('-');
		cout << setw(7) << left << "-" << "-+-" << setw(6) << left << '-' << endl;             // OUTPUT divider between data and statistics
		cout << setfill(' ');
		cout << setw(8) << left << "Sum" << '|' << setw(7) << right << sum << endl;             // OUTPUT sum
		cout << setw(8) << left << "Average" << '|' << setw(7) << right << average << endl;     // OUTPUT average
		cout << setw(8) << left << "Maximum" << '|' << setw(7) << right << maxNumber << endl; // OUTPUT maximum number
		cout << setw(8) << left << "Minimum" << '|' << setw(7) << right << minNumber << endl; // OUTPUT minimum number
	}
	else
	{
		cout << "The statistics could not be computed because no numbers existed.";
	}

	// Wait for a character to close the console, and close the files.
	_getch();
	inputFile.close();
	outputFile.close();

    return 0;
}

