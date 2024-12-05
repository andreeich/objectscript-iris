Class Library.BookREST Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/books" Method="GET" Call="GetBooks"/>
  <Route Url="/books/:id" Method="GET" Call="GetBook"/>
  <Route Url="/books" Method="POST" Call="CreateBook"/>
  <Route Url="/books/:id" Method="PUT" Call="UpdateBook"/>
  <Route Url="/books/:id" Method="DELETE" Call="DeleteBook"/>
</Routes>
}

ClassMethod GetBooks() As %Status
{
  Set st = $$$OK
  Try {
    Set sql = "SELECT ID, Title, Author, ISBN, PageCount, PublicationDate, CopiesAvailable FROM Library.Book"
    Do ##class(%ZEN.Auxiliary.jsonSQLProvider).%WriteJSONFromSQL(,sql)
  } Catch (ex) {
    Set st = ex.AsStatus()
  }
  Quit st
}

ClassMethod GetBook(id As %String) As %Status
{
  Set st = $$$OK
  Try {
    Set sql = "SELECT ID, Title, Author, ISBN, PageCount, PublicationDate, CopiesAvailable FROM Library.Book WHERE ID = "_id
    Do ##class(%ZEN.Auxiliary.jsonSQLProvider).%WriteJSONFromSQL(,sql)
  } Catch (ex) {
    Set st = ex.AsStatus()
  }
  Quit st
}

ClassMethod CreateBook() As %Status
{
  Set st = $$$OK
  Try {
    Do ##class(%ZEN.Auxiliary.jsonProvider).%ConvertJSONToObject(%request.Content, "Library.Book", .p)
    Set st = p.%Save()
  } Catch (ex) {
    Set st = ex.AsStatus()
  }
  Quit st
}

ClassMethod UpdateBook(id As %String) As %Status
{
  Set st = $$$OK
  Try {
    Do ##class(%ZEN.Auxiliary.jsonProvider).%ConvertJSONToObject(
    %request.Content,
    "Library.Book"
    , .temp)
    Set p = ##class(Library.Book).%OpenId(id)
    Set p.Title = temp.Title
    Set p.Author = temp.Author
    Set p.ISBN = temp.ISBN
    Set p.PageCount = temp.PageCount
    Set p.PublicationDate = temp.PublicationDate
    Set p.CopiesAvailable = temp.CopiesAvailable
    Set st = p.%Save()
  } Catch (ex) {
    Set st = ex.AsStatus()
  }
  Quit st
}

ClassMethod DeleteBook(id As %String) As %Status
{
  Set st = $$$OK
  Try {
      Set st = ##class(Library.Book).%DeleteId(id)
  } Catch (ex) {
      Set st = ex.AsStatus()
  }
  Quit st
}

}
