//
//  main.swift
//  challenge
//
//  Created by João Brentano on 15/03/21.
//

import Foundation

/*
 A school network has X schools and a lot of employees. Some of the employees are paid by hour (teachers) and some are paid by month (people from the support team).
 Each employee has: registration number, full name and role. The employees paid by month have a monthly salary and the employees paid by hour have the value of the hours (it can be different from each employee) and the amount of hours worked for a given month.
 Each school needs to know how much it spends per month with each employee and also the monthly expense with payroll.
 The school network needs an annual salary report.
 You can create as many employees as you want to and add them in any school. Let’s assume each employee is exclusive of a school.
*/

protocol Employee {
    var registratioNumber: Int { get }
    var fullName: String { get }
    var role: String { get }
    
    func getAmountPaidMonth() -> Double
}

protocol PaidMonthly: Employee {
    var salary: Double { get }
}

protocol PaidHourly: Employee {
    var hourPrice: Double { get }
    var hoursWorked: Double { get }
}

struct EmployeeMonthly: Employee, PaidMonthly {
    var registratioNumber: Int
    var fullName: String
    var role: String
    var salary: Double
    
    func getAmountPaidMonth() -> Double {
        return salary
    }
}

struct EmployeeHourly: Employee, PaidHourly {
    var registratioNumber: Int
    var fullName: String
    var role: String
    var hourPrice: Double
    var hoursWorked: Double
    
    func getAmountPaidMonth() -> Double {
        return hourPrice * hoursWorked
    }
}

struct School {
    var employeeList: [Employee] = []
    
    func monthlyReport() -> String {
        var report: String = "Monthly Report: \n"
        for aEmployee in employeeList {
            report.append("Employee \(aEmployee.fullName)(\(aEmployee.role)): R$")
            if let hourlyEmployee = aEmployee as? PaidHourly {
                report.append("\(hourlyEmployee.hourPrice*hourlyEmployee.hoursWorked)")
            } else if let monthlyEmployee = aEmployee as? PaidMonthly {
                report.append("\(monthlyEmployee.salary)")
            }
            report.append(" \n")
        }
        report.append("End Report")
        return report
    }
    
    func annualReport() -> String {
        var report: String = "Annual Report: \n"
        for aEmployee in employeeList {
            report.append("Employee \(aEmployee.fullName)(\(aEmployee.role)): R$")
            if let hourlyEmployee = aEmployee as? PaidHourly {
                report.append("\(hourlyEmployee.hourPrice*hourlyEmployee.hoursWorked*12)")
            } else if let monthlyEmployee = aEmployee as? PaidMonthly {
                report.append("\(monthlyEmployee.salary*12)")
            }
            report.append(" \n")
        }
        report.append("End Report")
        return report
    }
}

var School1: School = School(employeeList: [Employee]())

School1.employeeList.append(EmployeeMonthly(registratioNumber: 1001, fullName: "João", role: "Teacher", salary: 40000.99))
School1.employeeList.append(EmployeeHourly(registratioNumber: 1002, fullName: "Lucas", role: "Teacher", hourPrice: 400.99, hoursWorked: 160))

print(School1.employeeList)

print(School1.monthlyReport())
print(School1.annualReport())

