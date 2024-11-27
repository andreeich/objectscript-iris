Class Library.Patron Extends %Persistent
{

Property Name As %String [ Required ];

Property Email As %String [ Required ];

Property BorrowedItems As list Of Library.LibraryItem;

ClassMethod GetPatronCount() As %Integer
{
  // Embedded SQL query
  &sql(SELECT COUNT(*) INTO :count FROM Library.Patron)
  Return count
}

ClassMethod GetPatronByEmail(email As %String) As %Library.ResultSet
{
  Set rs = ##class(%Library.ResultSet).%New()
  Set sql = "SELECT * FROM Library.Patron WHERE Email = ?"
  
  Do rs.Prepare(sql)
  Do rs.Execute(email)
  
  Quit rs
}

Storage Default
{
<Data name="PatronDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Email</Value>
</Value>
<Value name="4">
<Value>BorrowedItems</Value>
</Value>
</Data>
<DataLocation>^Library.PatronD</DataLocation>
<DefaultData>PatronDefaultData</DefaultData>
<IdLocation>^Library.PatronD</IdLocation>
<IndexLocation>^Library.PatronI</IndexLocation>
<StreamLocation>^Library.PatronS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
