Class Library.Magazine Extends Library.LibraryItem
{

Property Publisher As %String [ Required ];

Property IssueNumber As %Integer [ Required ];

Index IssueIndex On (Publisher, IssueNumber) [ Unique ];

ClassMethod GetMagazineCount() As %Integer
{
  // Embedded SQL query
  &sql(SELECT COUNT(*) INTO :count FROM Library.Magazine)
  Return count
}

ClassMethod GetMagazineByPublisher(publisher As %String) As %SQL.StatementResult
{
    Set sql = "SELECT * FROM Library.Magazine WHERE Publisher = ?"
    Set rs = ##class(%SQL.Statement).%New()
    Set sc = rs.%Prepare(sql)
    If $$$ISERR(sc) { Quit sc }
    
    Set result = rs.%Execute(publisher)
    Quit result
}

Storage Default
{
<Data name="MagazineDefaultData">
<Subscript>"Magazine"</Subscript>
<Value name="1">
<Value>Publisher</Value>
</Value>
<Value name="2">
<Value>IssueNumber</Value>
</Value>
</Data>
<DefaultData>MagazineDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
