Class Library.Librarian Extends %Persistent
{

Property Name As %String [ Required ];

Property Position As %String [ Required ];

Property Resume As %Stream.GlobalCharacter;

Method AddItem(item As Library.LibraryItem) As %Status
{
    Quit item.%Save()
}

Method RemoveItem(item As Library.LibraryItem) As %Status
{
    Quit item.%Delete()
}

Method SearchItems(searchTerm As %String) As %ListOfObjects
{
    Set items = ##class(%ListOfObjects).%New()
    &sql(DECLARE C1 CURSOR FOR 
         SELECT ID FROM Library.LibraryItem 
         WHERE Title %STARTSWITH :searchTerm)
    &sql(OPEN C1)
    For { 
        &sql(FETCH C1 INTO :id)
        Quit:SQLCODE
        Set item = ##class(Library.LibraryItem).%OpenId(id)
        Do items.Insert(item)
    }
    &sql(CLOSE C1)
    Quit items
}

Storage Default
{
<Data name="LibrarianDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Position</Value>
</Value>
<Value name="4">
<Value>Resume</Value>
</Value>
</Data>
<DataLocation>^Library.LibrarianD</DataLocation>
<DefaultData>LibrarianDefaultData</DefaultData>
<IdLocation>^Library.LibrarianD</IdLocation>
<IndexLocation>^Library.LibrarianI</IndexLocation>
<StreamLocation>^Library.LibrarianS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
