// Author: Hunter Ducharme
// Program: 
// Inputs:
// Outputs"

#include "stdafx.h"
#include <iostream> // input and output
#include <conio.h>  // _getch()
#include <string>   // input strings

using namespace std;

void functionOne();
void functionTwo(double& number);
void functionThree();
void functionFour();
void functionFive(int M, int N);
void functionSix();
bool functionSeven(double number, double M, double N);
void functionEight(int M, int N);

int main()
{
	double k = 5.0;
	int mInt = 15;
	int nInt= 25;
	double mDouble = 20;
	double nDouble = 30;

	functionOne();
	functionTwo(k);
	functionThree();
	functionFour();
	functionFive(mInt, nInt);
	functionSix();
	functionSeven(k, mDouble, nDouble);
	functionEight(mInt, nInt);

	// Wait for a character to exit the console.
	cout << "Press any button to exit the console... ";
	_getch();

	return 0;
}

// 1. Function to enter a number.
void functionOne()
{
	double number;
	cout << "Enter a number: ";
	cin >> number;
	cout << endl;
	cout << "You enter the number " << number << endl;
}

// 2. Function to enter a number using reference.
void functionTwo(double& number)
{
	cout << "Enter a number: ";
	cin >> number;
	cout << endl;
	cout << "You entered the number " << number << endl;
}

// 3. Function to print a number.
void functionThree()
{
	double number;
	cout << "Enter a number: ";
	cin >> number;
	cout << endl;
	cout << "You entered the number " << endl;
}

// 4. Function to print the numbers between 1 and 10.
void functionFour()
{
	int i;
	for (i = 1; i <= 10; i++) {
		cout << i << endl;
	}
}

// 5. Function to print the numbers between M and N.
void functionFive(int M, int N)
{
	int i;
	for (i = M; (i > M && i < N); ++i) {
		cout << i << endl;
	}
}

// 6. Print the even numbers between 10 and 20.
void functionSix()
{
	int i;
	for (i = 10; i < 20; ++i) {
		if (i % 2 != 0) {
			cout << " " << endl;
		}
		else {
			cout << i << endl;
		}
	}
}

// 7. Check if a number is between M and N.
bool functionSeven(double number, double M, double N)
{
	if (((number > M) && (number < N)) || ((number > N) && (number < M))) {
		return true;
	}

	return false;
}

// 8. Enter a number between M and N.
void functionEight(int M, int N)
{
	double number;

	if (M > N) {
		do {
			cout << "Enter a number between " << N << " and " << M << ": ";
			cin >> number;
		} while ((number > M) || (number < N));
		cout << "You entered the number " << number << endl;
	}
	else {
		do {
			cout << "Enter a number between " << M << " and " << N << ": ";
			cin >> number;
		} while ((number > N) || (number < M));
		cout << "You entered the number " << number << endl;
	}
}