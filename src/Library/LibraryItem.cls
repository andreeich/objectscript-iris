Class Library.LibraryItem Extends (%Persistent, %Populate) [ Abstract ]
{

Property Title As %String [ Required ];

Property PublicationDate As %Date [ Required ];

Property CopiesAvailable As %Integer [ Required ];

Property IsAvailable As %Boolean [ Calculated, SqlComputeCode = {Set {*} = ({CopiesAvailable} > 0)}, SqlComputed ];

Method IsAvailableGet() As %Boolean
{
  Return (..CopiesAvailable > 0)
}

Storage Default
{
<Data name="LibraryItemDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ID</Value>
</Value>
<Value name="3">
<Value>Title</Value>
</Value>
<Value name="4">
<Value>PublicationDate</Value>
</Value>
<Value name="5">
<Value>CopiesAvailable</Value>
</Value>
<Value name="6">
<Value>Patron</Value>
</Value>
</Data>
<DataLocation>^Library.LibraryItemD</DataLocation>
<DefaultData>LibraryItemDefaultData</DefaultData>
<IdLocation>^Library.LibraryItemD</IdLocation>
<IndexLocation>^Library.LibraryItemI</IndexLocation>
<StreamLocation>^Library.LibraryItemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
