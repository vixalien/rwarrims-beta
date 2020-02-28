# RWARRIMS

RwarriMS is an application to manage user information of workers at [Rwarri](http://rwarri.com). (Details at the end.)

# Features

## Sign-Up

When you sign up for a RwarriMS account, you are prompted for the following:

- Names
- E-Mail
- ID Card No
- Password

When you create your account, you wait for `Admin`s (discussed below) to confirm your account. When you are waiting, you are in a state called Pending.

## Log-In

When your account have been accepted and you have been assigned a `post` (discussed below), you can Log-In by providing your E-Mail and Password only.

## Attendance

### Checks

The employee can
- View Status (Last check was at ...)
- Check In (You are starting work)
- Check Out (You are leaving work)

### Log

The employee can see a `weekly` log of checks showing the checkins and checkouts done per day and also the Time Worked per day.

## Profile

An employee has a profile with a _name_, _email_, _ID Card_ and _Password_.

## Post and Position

A post in RwarriMS means a value of either `Admin` or `Employee`. An Admin has far more features available thsn a simple `Employee`, discussed below.

A position means the level of hierarchy a certain employee is on. There are **7** positions:

* Field Officer
* Senior Extensionist
* M&E Officer
* Finance Manager
* Accountant
* Driver
* Executive Director

In less words, an employee has access to these submodules:

* Attendance
* Profile

# Admin

An Admin is an employee with a `post` of `Admin`.
An Admin has all the access of the employee plus the following:

## Attendance Management

Attendance management is a tool provided to check the attendance record of all Employees.
This list each day of the week with all the employee's:

- Check-Ins
- Check-Outs
- Location (Lat, Long, City, Country)
- Browser e.g Firefox/70.1, Chrome/30.2
- OS (Operating System) e.g. Android 8.0, Windows NT 10, Windows NT 7

An `Admin` can

- Check a quick Weekly Report and view the hours worked for each Employee.
- Customize the _view_ and get results between selected Dates, Choose whether to show OS, Browser, Location

## Employee Managemement

Employee management is a feature in RwarriMs tha allows the modification of existent and pending Employees.

You can accept pending Employees by providing to them a `post` and `position`.

For Existent Employees, You can:

- Change some fields like:

	* Names
	* E-Mail
	* ID Card

- Change some _advanced_ fields which the Employee themself can't change.

	* Password
	* Post
	* Position

- You can also `delete` the account.

# What's Next

Features that RwarriMS can have on demand.

## Attendance Maps

Maps to show the exact Location of an Employee when he `checked attendance` or `logged in`.

## E-Mail confirmation

When an employee forgot a password or when logging in (as a secure proposition). They can receive E-Mails to make it easy to recover forgot passwords.

## Other Features

Other features are available on demand.

### Contacts

**Angelo Shema**

Email: [*geoangercola@gmail.com*](mailto:geoangercola@gmail.com)

Twitter: [@angeloshema](https://www.twitter.com/angeloshema)

Telephone: 0785730672

### Technical Details

**Current version: _0.25.0_**

**Current website: _[rwarrims-beta.herokuapp.com](https://rwarrims-beta.herokuapp.com)_**

**Last Signature Time: _8:21 PM +2:00 2/28/2020_**
