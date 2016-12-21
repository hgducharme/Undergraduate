// Author: Hunter Ducharme
// Program: This program calculates a customer's bill for a local cable company.
// Input: Customer's account number, customer code, number of premium channels,
//        and if a business customer, number of basic service connections.
// Output: Customer's account number and their bill.

// Header files.
#include "stdafx.h"
#include <iostream> // for cout and cin
#include <iomanip>  // for manipulators
#include <string>   // for cin << <string>
#include <conio.h>  // for _getch()

using namespace std;

// Constants for residential customers.
const double RESIDENTIAL_PROCESSING_FEE = 4.50;
const double RESIDENTIAL_SERVICE_FEE = 20.50;
const double RESIDENTIAL_PREMIUM_CHANNEL_FEE = 7.50;

// Constants for business customers.
const double BUSINESS_PROCESSING_FEE = 15.00;
const double BUSINESS_SERVICE_FEE = 75.00;
const double BUSINESS_PREMIUM_CHANNEL_FEE = 50.00;

int main()
{
	// Define variables.
	double accountNumber;
	int premiumChannels, basicServiceConnections;
	char customerCode = 'z';
	double totalPayment;

	// Define manipulators.
	cout << fixed << setprecision(0);

	// INPUT user's account number.
	cout << "Please enter your account number and press enter: ";
	cin >> accountNumber;

	// INPUT user's customer code. Until customer code is recognized, continue to prompt for customer code.
	while ((customerCode != 'R') && (customerCode != 'B'))
	{
		cout << "Please enter your customer code and press enter ('r' or 'R' for residential, 'b' or 'B' for business): ";
		cin >> customerCode;
		customerCode = toupper(static_cast<int>(customerCode));
	}

	// INPUT number of premium channels.
	cout << "Please enter the number of premium channels you have and press enter: ";
	cin >> premiumChannels;

	// INPUT number of basic service connections if business customer.
	if (customerCode == 'B')
	{
		cout << "Please enter the number of basic service connections you have and press enter: ";
		cin >> basicServiceConnections;
	}

	// COMPUTE AND OUTPUT customer's bill and account number.
	switch (customerCode)
	{
	case 'R':
		totalPayment = RESIDENTIAL_PROCESSING_FEE + RESIDENTIAL_SERVICE_FEE + (RESIDENTIAL_PREMIUM_CHANNEL_FEE*premiumChannels);
		cout << "\nAccount number: " << accountNumber << endl << "Billing amount: $" << setprecision(2) << totalPayment;
		break;
	case 'B':
		double businessServiceFee = 0.0;

		// Calculate basic service fee based on the amount of basic service connections.
		if (basicServiceConnections < 10)
		{
			businessServiceFee = 75.00;
		}
		else
		{
			businessServiceFee = 75.00 + (basicServiceConnections - 10)*(BUSINESS_SERVICE_FEE);
		}

		totalPayment = BUSINESS_PROCESSING_FEE + businessServiceFee + (BUSINESS_PREMIUM_CHANNEL_FEE*premiumChannels);
		cout << "\nAccount number: " << accountNumber << endl << "Billing amount: $" << setprecision(2) << totalPayment;
		break;
	}

	// Wait for a character to close the console.
	cout << "\n\nPress any button to close the console...";
	_getch();

	return 0;
}

