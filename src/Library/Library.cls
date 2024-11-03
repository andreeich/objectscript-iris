Class Library.Library Extends %Persistent
{

Property Name As %String [ Required ];

Property Address As %String [ Required ];

Property Inventory As array Of Library.LibraryItem;

Property RegisteredPatrons As list Of Library.Patron;

Property Staff As list Of Library.Librarian [ Required ];

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
