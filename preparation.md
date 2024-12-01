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
