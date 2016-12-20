// Author: Hunter Ducharme
// Program: This program computes the area of a square with side x,
//          the area of a rectangle with length 2x and width x,
//          and the area of a circle with radius x.
// Input: An integral number x.
// Output: The area of the square, the rectangle, and the circle.

#include "stdafx.h"
#include <iostream>
#include <conio.h>
#define _USE_MATH_DEFINES
#include <math.h>

using namespace std;

int main()
{
	// Tell the user what the program does.
	cout << "This program computes the area of a square, rectangle, and circle.\n\n";

	// Declare variables for integral number x, area of the square, rectangle, and circle.
	int x;
	int areaSquare, areaRectangle;
	double areaCircle;

	// INPUT the integral number x
	cout << "Please input an integer x: ";
	cin >> x;
	cout << endl;

	// COMPUTE the area of the square, rectangle, and circle.
	areaSquare = pow(x, 2);
	areaRectangle = 2 * pow(x, 2);
	areaCircle = (M_PI)*pow(x, 2);

	// OUTPUT the area of the square, rectangle, and circle.
	cout << "The area of a square with side length " << x << " is " << areaSquare << endl;
	cout << "The area of a rectangle with length " << 2 * x << " and height " << x << " is " << areaRectangle << endl;
	cout << "The area of a circle with radius " << x << " is " << areaCircle << endl;

	// Wait for a character before closing the console.
	cout << "\nPress any key to close the console...";
	_getch();

	return 0;
}