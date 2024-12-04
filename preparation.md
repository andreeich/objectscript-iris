# Preparation file

## Laboratory \#5

Add an always computed property to one of the classes and write a getter for it.
Create code for automatic data generation for all classes.
Create code for Unit Testing a class/classes where there are unique, required, constrained properties and relationship and check that all tests succeed:

- Test creation of the object
- Test unique, required, constrained properties
- Test behavior when deleting an object with many/children relationship
- Test deletion of the object

```objectscript
do ^SetupTests
Do ##class(%UnitTest.Manager).RunTest(test, quals)
```

## Laboratory \#6

Add queries to all classes.

- At least one of them must have arguments.
- At least one of them must be COS based query.

Use dynamic and embedded SQL in methods.
Use implicit `join (->)`.
Create a trigger and code to trigger it.
Change Unique index to IDKEY and run script for creating objects from practice 4. See that the presentation in Globals changed.
All methods should make sense

## Laboratory \#7

> Use CSP to create web pages that allow you to work with objects of a class from laboratory work №4.
Use direct access to the database to display a table with all the objects of the chosen class and create buttons for editing, creating and deleting objects using services.
Create a RESTful service and a corresponding client that allows you to edit, create and delete objects.
Create a SOAP service and its corresponding client that allows you to edit, create and delete objects.

### Web service

- View book list by url `http://localhost:50407/csp/user/BookList.csp`

- Add new a book by clicking the 'Create New Book' button

- Edit a book by clicking 'Edit' icon near corresponding book's row

- Delete an existing book by clicking 'Delete' icon near corresponding book's row
