Class Library.BookSOAP Extends %SOAP.WebService
{

Parameter SERVICENAME = "Library.BookSOAP";

Parameter NAMESPACE = "http://tempuri.org";

Method GetBooks() As %DynamicArray
{
    Set tStatement = ##class(%SQL.Statement).%New()
    Set tQuery = "SELECT ID, Title, Author, ISBN, PageCount, PublicationDate, CopiesAvailable FROM Library.Book"
    Do tStatement.%Prepare(tQuery)
    Set tResult = tStatement.%Execute()
    Set books = []
    While tResult.%Next() {
        Set book = ##class(%DynamicObject).%New()
        Set book.ID = tResult.%Get("ID")
        Set book.Title = tResult.%Get("Title")
        Set book.Author = tResult.%Get("Author")
        Set book.ISBN = tResult.%Get("ISBN")
        Set book.PageCount = tResult.%Get("PageCount")
        Set book.PublicationDate = tResult.%Get("PublicationDate")
        Set book.CopiesAvailable = tResult.%Get("CopiesAvailable")
        Do books.%Push(book)
    }
    Quit books
}

Method GetBook(id As %String) As %DynamicObject
{
    Set book = ##class(Library.Book).%OpenId(id)
    If '$ISOBJECT(book) {
        Quit $$$ERROR($$$GeneralError, "Book not found")
    }
    Quit book
}

Method CreateBook(book As %DynamicObject) As %DynamicObject
{
    Set newBook = ##class(Library.Book).%New()
    Set newBook.Title = book.Title
    Set newBook.Author = book.Author
    Set newBook.ISBN = book.ISBN
    Set newBook.PageCount = book.PageCount
    Set newBook.PublicationDate = book.PublicationDate
    Set newBook.CopiesAvailable = book.CopiesAvailable
    Set sc = newBook.%Save()
    If $$$ISERR(sc) {
        Quit sc
    }
    Quit newBook
}

Method UpdateBook(id As %String, book As %DynamicObject) As %DynamicObject
{
    Set existingBook = ##class(Library.Book).%OpenId(id)
    If '$ISOBJECT(existingBook) {
        Quit $$$ERROR($$$GeneralError, "Book not found")
    }
    Set existingBook.Title = book.Title
    Set existingBook.Author = book.Author
    Set existingBook.ISBN = book.ISBN
    Set existingBook.PageCount = book.PageCount
    Set existingBook.PublicationDate = book.PublicationDate
    Set existingBook.CopiesAvailable = book.CopiesAvailable
    Set sc = existingBook.%Save()
    If $$$ISERR(sc) {
        Quit sc
    }
    Quit existingBook
}

Method DeleteBook(id As %String) As %Status
{
    Set sc = ##class(Library.Book).%DeleteId(id)
    If $$$ISERR(sc) {
        Quit sc
    }
    Quit $$$OK
}

}
