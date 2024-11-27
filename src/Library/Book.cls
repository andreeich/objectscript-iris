Class Library.Book Extends Library.LibraryItem
{

Property Author As %String(POPSPEC = "Name()") [ Required ];

Property PageCount As %Integer(POPSPEC = "Integer(1,1000)") [ Required ];

Property ISBN As %String(POPSPEC = "String(13)") [ Required ];

ClassMethod GetBookCount() As %Integer
{
  // Embedded SQL query
  &sql(SELECT COUNT(*) INTO :count FROM Library.Book)
  Return count
}

ClassMethod GetBookByAuthor(author As %String) As %SQL.StatementResult
{
    Set sql = "SELECT * FROM Library.Book WHERE Author = ?"
    Set rs = ##class(%SQL.Statement).%New()
    Set sc = rs.%Prepare(sql)
    If $$$ISERR(sc) { Quit sc }
    
    Set result = rs.%Execute(author)
    Quit result
}

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
