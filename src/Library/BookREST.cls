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
    Set tStatement = ##class(%SQL.Statement).%New()
    Set tQuery = "SELECT ID, Title, Author, ISBN, PageCount, PublicationDate, CopiesAvailable FROM Library.Book"
    #; Do tStatement.%Prepare(tQuery)
    #; Set tResult = tStatement.%Execute()
    #; Set books = []
    #; While tResult.%Next() {
    #;     Set book = ##class(%DynamicObject).%New()
    #;     Do book.%Set("ID", tResult.%Get("ID"))
    #;     Do book.%Set("Title", tResult.%Get("Title"))
    #;     Do book.%Set("Author", tResult.%Get("Author"))
    #;     Do book.%Set("ISBN", tResult.%Get("ISBN"))
    #;     Do book.%Set("PageCount", tResult.%Get("PageCount"))
    #;     Do book.%Set("PublicationDate", tResult.%Get("PublicationDate"))
    #;     Do book.%Set("CopiesAvailable", tResult.%Get("CopiesAvailable"))
    #;     Do books.%Push(book)
    #; }
    #; set sql = "SELECT ID As id, Name As name FROM Demo_Data.""Group"" "_
 	#; 			  "WHERE Faculty = "_facultyId_" ORDER BY name"

    Do ##class(%ZEN.Auxiliary.jsonSQLProvider).%WriteJSONFromSQL(,tQuery)
    #; Do %response.SetStatus(200)
    #; Do books.ObjectToJSON(books)
    Quit $$$OK
}

ClassMethod GetBook(id As %String) As %Status
{
    Set book = ##class(Library.Book).%OpenId(id)
    If '$ISOBJECT(book) {
        Do %response.SetStatus(404)
        Quit $$$ERROR($$$GeneralError, "Book not found")
    }
    Do %response.SetStatus(200)
    Do %response.ObjectToJSON(book)
    Quit $$$OK
}

ClassMethod CreateBook() As %Status
{
    Set book = ##class(Library.Book).%New()
    Set book.Title = %request.Data("Title")
    Set book.Author = %request.Data("Author")
    Set book.ISBN = %request.Data("ISBN")
    Set book.PageCount = %request.Data("PageCount")
    Set book.PublicationDate = %request.Data("PublicationDate")
    Set book.CopiesAvailable = %request.Data("CopiesAvailable")
    Set sc = book.%Save()
    If $$$ISERR(sc) {
        Do %response.SetStatus(500)
        Quit sc
    }
    Do %response.SetStatus(201)
    Do %response.ObjectToJSON(book)
    Quit $$$OK
}

ClassMethod UpdateBook(id As %String) As %Status
{
    Set book = ##class(Library.Book).%OpenId(id)
    If '$ISOBJECT(book) {
        Do %response.SetStatus(404)
        Quit $$$ERROR($$$GeneralError, "Book not found")
    }
    Set book.Title = %request.Data("Title")
    Set book.Author = %request.Data("Author")
    Set book.ISBN = %request.Data("ISBN")
    Set book.PageCount = %request.Data("PageCount")
    Set book.PublicationDate = %request.Data("PublicationDate")
    Set book.CopiesAvailable = %request.Data("CopiesAvailable")
    Set sc = book.%Save()
    If $$$ISERR(sc) {
        Do %response.SetStatus(500)
        Quit sc
    }
    Do %response.SetStatus(200)
    Do %response.ObjectToJSON(book)
    Quit $$$OK
}

ClassMethod DeleteBook(id As %String) As %Status
{
    Set sc = ##class(Library.Book).%DeleteId(id)
    If $$$ISERR(sc) {
        Do %response.SetStatus(500)
        Quit sc
    }
    Do %response.SetStatus(204)
    Quit $$$OK
}

}
