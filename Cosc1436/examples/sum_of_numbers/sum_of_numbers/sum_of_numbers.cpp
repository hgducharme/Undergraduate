// Author: Hunter Ducharme
// Program: This program computes the sum of inputted numbers until the user inputs 100. It also finds the average, max, and min number.
// Input: Numbers
// Output: The sum of the numbers, the lowest number, and the highest number.

#include "stdafx.h"
#include <iostream>
#include <iomanip>
#include <conio.h>
using namespace std;


int main()
{
	// Define variables
	double sum=0, average=0, maxNumber=0, minNumber=1000000000, currentNumber;
	int count = 0;

	do
	{
		count++;

		// INPUT numbers until user inputs 100
		cout << "Please input a number and press enter: ";
		cin >> currentNumber;

		// COMPUTE sum, largest number, and smallest number. 
		sum = sum + currentNumber;
		(currentNumber > maxNumber) ? maxNumber = currentNumber : 0; // Find the largest number inputted.
		(currentNumber < minNumber) ? minNumber = currentNumber : 0; // Find the smallest number inputted.
	} while (currentNumber != 100);

	// COMPUTE average
	average = sum / count;

	// OUTPUT amount of numbers inputted, sum, average, max number, and min number.
	cout << fixed << setprecision(2);
	cout << "\nYou entered " << count << " numbers." << endl;
	cout << "Sum: " << sum << endl;
	cout << "Average: " << average << endl;
	cout << "Largest number: " << maxNumber << endl;
	cout << "Smallest number: " << minNumber << endl;

	// Wait for a character to close the console.
	_getch();

    return 0;
}

