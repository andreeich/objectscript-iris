Class Library.Librarian Extends %Persistent
{

Property Name As %String [ Required ];

Property Position As %String [ Required ];

Property Resume As %Stream.GlobalCharacter;

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
