// Author: Hunter Ducharme
// Program: This program reads a formatted file with names and 2 test scores for each name, and ouputs statistics on that student.
// Input: Input file with format: <name> <test 1 score> <test 2 score>.
// Output: For each student, output the total points for all tests, numeric grade, the letter grade,
//         the number of students, the average numeric grade, and the minimum and maximum numberic grade.

#include "stdafx.h"
#include <iostream> // for cin and cout
#include <conio.h>  // for _getch()
#include <fstream>  // for file input/output
#include <iomanip>  // for input/output manipulators
#include <string>   // for inputting a string
#include <stdlib.h> // for exit()
using namespace std;


int main()
{
	// Define variables for manipulating data
	int numberOfStudents = 0;
	double numericGradeSum = 0, numericGradeAverage;
	double minimumNumericGrade = 100, maximumNumericGrade = 0;

	// Define output manipulators
	cout << setfill(' ') << fixed << setprecision(2);

	// Define file variables
	ifstream inputFile("grades.txt");
	ofstream outputFile("outputFile.txt");

	if (inputFile.bad())
	{
		cout << "ERROR: could not open input file. Aborting program.";
		exit;
	}
	else
	{
		cout << "Input file successfully opened." << endl;
	}

	// OUTPUT table header with format: Name | Total Points | Numeric Grade | Letter grade
	cout << "\nSTUDENT STATISTICS:\n\n";
	cout << setw(26) << left << "Name" << setw(10) << left << "Total"  << setw(10) << left << "Numeric" << setw(10) << "Letter" << endl;
	cout << setw(26) << left << " "    << setw(10) << left << "Points" << setw(10) << left << "Grade"   << setw(10) << "Grade" << endl;

	while (inputFile)
	{
		if (inputFile.eof())
			break;

		// Define variables to be retrieved
		numberOfStudents++;
		string row, name;
		double testScore1, testScore2, totalPoints;
		double numericGrade = -1;
		char letterGrade = 'X';

		// INPUT variables from input file
		inputFile >> name >> testScore1 >> testScore2;

		// COMPUTE the student's total points, numeric grade, and letter grade.
		totalPoints = testScore1 + testScore2;
		numericGrade = totalPoints / 2;
		if (numericGrade >= 90)                      // letterGrade = A
			letterGrade = 'A';
		if (numericGrade >= 80 && numericGrade < 90) // letterGrade = B
			letterGrade = 'B';
		if (numericGrade >= 70 && numericGrade < 80) // letterGrade = C
			letterGrade = 'C';
		if (numericGrade >= 60 && numericGrade < 70) // letterGrade = D
			letterGrade = 'D';
		if (numericGrade >= 0 && numericGrade < 60)  // letterGrade = F
			letterGrade = 'F';

		// UPDATE minimum number, maximum number, and sum of numeric grades.
		numericGradeSum = numericGradeSum + numericGrade;
		if (numericGrade > maximumNumericGrade)
			maximumNumericGrade = numericGrade;
		if (numericGrade < minimumNumericGrade)
			minimumNumericGrade = numericGrade;

		// OUTPUT table rows with format: Name | Total Points | Numeric Grade | Letter Grade 
		cout << setw(26) << left << name << setw(10) << left << totalPoints << setw(10) << left << numericGrade << setw(10) << letterGrade << endl;
	}

	// COMPUTE class average
	numericGradeAverage = numericGradeSum / numberOfStudents;

	// OUTPUT class statistics
	cout << "\nCLASS STATISTICS:\n\n";
	cout << setw(26) << left << "Number of Students" << setw(10) << left << numberOfStudents << endl;
	cout << setw(26) << left << "Minimum:" << setw(10) << left << minimumNumericGrade << endl;
	cout << setw(26) << left << "Maximum:" << setw(10) << left << maximumNumericGrade << endl;
	cout << setw(26) << left << "Class Average:" << setw(10) << left << numericGradeAverage << endl;

	// Wait for a character to exit the console.
	cout << "\n\nPress any button to exit the console... ";
	_getch();

    return 0;
}