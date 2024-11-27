Class Library.Library Extends (%Persistent, %Populate)
{

Property Name As %String(POPSPEC = "Name()") [ Required ];

Property Address As %String(POPSPEC = "Street()") [ Required ];

Property Inventory As list Of Library.LibraryItem;

Property RegisteredPatrons As list Of Library.Patron;

Property Staff As list Of Library.Librarian [ Required ];

ClassMethod GetAllBooksByLibraryName(libraryName As %String, bookID As %String) As %SQL.StatementResult
{
    Set sql = "SELECT b.Title, b.Author, b.ISBN FROM Library.Book b JOIN Library.Library l ON b.ID %INLIST l.Inventory Where l.Name = ?"
    #; Set sql = "SELECT b.* FROM Library.Library b WHERE b.Name = ?"
    #; Set sql = "SELECT b.* FROM Library.Book b WHERE b.ID->"
    Set rs = ##class(%SQL.Statement).%New()
    Set sc = rs.%Prepare(sql)
    If $$$ISERR(sc) { 
        #; Do $SYSTEM.OBJ.DisplayError(sc)
        #; Write !,sc
        Quit sc
    }

    Set result = rs.%Execute(libraryName)
    Quit result
}

ClassMethod GetAllLibraryNames() As %Status
{
    &sql(select Name into :res from Library.Library)
    Write !, res
    
    Quit $$$OK
}

// Unique index for Name

Index NameIndex On Name [ Unique ];

Storage Default
{
<Data name="LibraryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Address</Value>
</Value>
<Value name="4">
<Value>Inventory</Value>
</Value>
<Value name="5">
<Value>RegisteredPatrons</Value>
</Value>
<Value name="6">
<Value>Staff</Value>
</Value>
</Data>
<DataLocation>^Library.LibraryD</DataLocation>
<DefaultData>LibraryDefaultData</DefaultData>
<IdLocation>^Library.LibraryD</IdLocation>
<IndexLocation>^Library.LibraryI</IndexLocation>
<StreamLocation>^Library.LibraryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
