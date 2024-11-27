Class Library.Librarian Extends (%Persistent, %Populate)
{

Property Name As %String(POPSPEC = "Name()") [ Required ];

Property Position As %String(POPSPEC = "Title()") [ Required ];

Property Resume As %Stream.GlobalCharacter(POPSPEC = "String(1000)");

ClassMethod GetLibrarianCount() As %Integer
{
  // Embedded SQL query
  &sql(SELECT COUNT(*) INTO :count FROM Library.Librarian)
  Return count
}

ClassMethod GetLibrarianByPosition(position As %String) As %Library.ResultSet
{
  Set rs = ##class(%Library.ResultSet).%New()
  Set sql = "SELECT * FROM Library.Librarian WHERE Position = ?"
  
  Do rs.Prepare(sql)
  Do rs.Execute(position)
  
  Quit rs
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
