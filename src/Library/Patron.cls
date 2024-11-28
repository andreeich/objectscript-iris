Class Library.Patron Extends (%Persistent, %Populate)
{

Property Name As %String(POPSPEC = "Name()") [ Required ];

Property Email As %String(POPSPEC = "String(13)") [ Required ];

Relationship LibraryItems As Library.LibraryItem [ Cardinality = parent, Inverse = Patron ];

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

ClassMethod GetAllLibraryItemsByPatronName(patronName As %String) As %SQL.StatementResult
{
  Set sql = "SELECT li.Title FROM Library.LibraryItem li JOIN Library.Patron p ON li.Patron = p.ID WHERE p.Name = ?"
  Set rs = ##class(%SQL.Statement).%New()
  Set sc = rs.%Prepare(sql)
  If $$$ISERR(sc) { Quit sc }
  
  Set result = rs.%Execute(patronName)
  Quit result
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
