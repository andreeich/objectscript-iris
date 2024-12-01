Class Library.Magazine Extends Library.LibraryItem
{

Property Publisher As %String(POPSPEC = "Company()") [ Required ];

Property IssueNumber As %Integer(POPSPEC = "Integer(1,1000)") [ Required ];

Index IssueIndex On (Publisher, IssueNumber) [ Unique ];

Relationship Patron As Library.Patron [ Cardinality = children, Inverse = Magazines ];

ClassMethod GetMagazineCount() As %Integer
{
  // Embedded SQL query
  &sql(SELECT COUNT(*) INTO :count FROM Library.Magazine)
  Return count
}

ClassMethod GetMagazineById(id As %Integer) As %SQL.StatementResult
{
  Set sql = "SELECT * FROM Library.Magazine WHERE ID = ?"
  Set rs = ##class(%SQL.Statement).%New()
  Set sc = rs.%Prepare(sql)
  If $$$ISERR(sc) { Quit sc }
  
  Set result = rs.%Execute(id)
  Quit result
}

// ClassMethod GetAllMagazines() As %SQL.StatementResult

// {

//   Set sql = "SELECT * FROM Library.Magazine"

//   Set rs = ##class(%SQL.Statement).%New()

//   Set sc = rs.%Prepare(sql)

//   If $$$ISERR(sc) { Quit sc }

//   Set result = rs.%Execute()

//   Quit result

// }

ClassMethod GetAllMagazines() As %Status
{
  &sql(DECLARE MagazineCursor CURSOR FOR
       SELECT ID, Publisher, IssueNumber FROM Library.Magazine)
  
  &sql(OPEN MagazineCursor)
  
  While (1) {
    &sql(FETCH MagazineCursor INTO :id, :publisher, :issueNumber)
    If SQLCODE '= 0 {
      Write "ID: ", id, ", Publisher: ", publisher, ", IssueNumber: ", issueNumber, !
    } Else {
      Quit
    }
  }
  
  &sql(CLOSE MagazineCursor)
  
  Quit $$$OK
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
