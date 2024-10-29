Class Library.Book Extends Library.LibraryItem
{

Property Author As %String [ Required ];

Property PageCount As %Integer [ Required ];

Property ISBN As %String [ Required ];

// Unique index for ISBN

Index ISBNIndex On ISBN [ Unique ];

Storage Default
{
<Data name="BookDefaultData">
<Subscript>"Book"</Subscript>
<Value name="1">
<Value>Author</Value>
</Value>
<Value name="2">
<Value>PageCount</Value>
</Value>
<Value name="3">
<Value>ISBN</Value>
</Value>
</Data>
<DefaultData>BookDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
