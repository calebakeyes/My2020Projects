//This program allows you to calculate the amount of money you will have when you retire. 

package com.calebkeyes;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("What is your age?");
        Integer currentAge = Integer.parseInt(scanner.nextLine());

        System.out.println("What age do you expect to retire?");
        Integer retirementAge = Integer.parseInt(scanner.nextLine());

        Integer numberOfWorkingYears = retirementAge - currentAge;

        System.out.println("What is your current salary?");
        Integer currentSalary = Integer.parseInt(scanner.nextLine());

        System.out.println("What percent do you expect your salary to grow per year?");
        Double salaryAnnualGrowth = Double.valueOf(Integer.parseInt(scanner.nextLine()));

        System.out.println("What percent of your salary will you put in your 401k/IRA every year? (10-15% is recommended)");
        Double percentToPutIn = Double.valueOf(Integer.parseInt(scanner.nextLine()));

        System.out.println("How much do you currently have in your retirement savings (i.e. money in your IRA or 401k)?");
        Integer currentSavings = Integer.parseInt(scanner.nextLine());

        System.out.println("What percent do you expect your balance to grow? (usually 6%)");
        Double portfolioAnnualGrowth = Double.valueOf(Integer.parseInt(scanner.nextLine()));

        Integer newSalary = 0;
        Integer additionalSavings = 0;
        Integer totalRetirementSavings = 0;
        Integer returnAmount = 0;

        for (int currentYear = 0; currentYear < numberOfWorkingYears; currentYear++) {
            newSalary = (int) (currentSalary + (currentSalary * salaryAnnualGrowth *.01));
            additionalSavings = (int) (newSalary * percentToPutIn *.01);
            totalRetirementSavings = (currentSavings + additionalSavings);
            returnAmount = (int) (totalRetirementSavings * portfolioAnnualGrowth * .01);
            currentSavings = totalRetirementSavings + returnAmount;
            currentSalary = newSalary;
        }
        System.out.println("You should expect to have $" + currentSavings + " when you retire.");
    }
}

