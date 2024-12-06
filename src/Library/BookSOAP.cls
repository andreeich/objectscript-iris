Class Library.BookSOAP Extends %SOAP.WebService
{

Parameter SERVICENAME = "Library.BookSOAP";

Parameter NAMESPACE = "http://tempuri.org";

Parameter USECLASSNAMESPACES = 1;

Method GetBooks() As %String [ WebMethod ]
{
  Set tStatement = ##class(%SQL.Statement).%New()
  Set tQuery = "SELECT ID, Title, Author, ISBN, PageCount, PublicationDate, CopiesAvailable FROM Library.Book"
  Do tStatement.%Prepare(tQuery)
  Set tResult = tStatement.%Execute()
  Set books = ##class(%ArrayOfObjects).%New()
  Set result = ""
  While tResult.%Next() {
      Set book = ##class(Library.Book).%OpenId(tResult.%Get("ID"))
      Set result = result _ " " _ book.Title
  }
  Quit result
}

Method GetBook(id As %String) As %String [ WebMethod ]
{
  Set book = ##class(Library.Book).%OpenId(id)
  If '$ISOBJECT(book) {
      Set fault = ..MakeStatusFault($$$FAULTSender, "Book not found", $$$ERROR($$$GeneralError, "Book not found"))
      Do ..ReturnFault(fault)
      Quit ""
  }
  Quit book
}

Method CreateBook(Title As %String, Author As %String, ISBN As %String, PageCount As %Integer, PublicationDate As %Integer, CopiesAvailable As %Integer) As %String [ WebMethod ]
{
  Set newBook = ##class(Library.Book).%New()
  Set newBook.Title = Title
  Set newBook.Author = Author
  Set newBook.ISBN = ISBN
  Set newBook.PageCount = PageCount
  Set newBook.PublicationDate = PublicationDate
  Set newBook.CopiesAvailable = CopiesAvailable
  Set sc = newBook.%Save()
  If $$$ISERR(sc) {
      Set fault = ..MakeStatusFault($$$FAULTSender, "Create problem", sc)
      Do ..ReturnFault(fault)
      Quit ""
  }
  Quit newBook
}

Method UpdateBook(id As %String, Title As %String, Author As %String, ISBN As %String, PageCount As %Integer, PublicationDate As %Integer, CopiesAvailable As %Integer) As %String [ WebMethod ]
{
  Set existingBook = ##class(Library.Book).%OpenId(id)
  If '$ISOBJECT(existingBook) {
      Set fault = ..MakeStatusFault($$$FAULTSender, "Book not found", $$$ERROR($$$GeneralError, "Book not found"))
      Do ..ReturnFault(fault)
      Quit ""
  }
  Set existingBook.Title = Title
  Set existingBook.Author = Author
  Set existingBook.ISBN = ISBN
  Set existingBook.PageCount = PageCount
  Set existingBook.PublicationDate = PublicationDate
  Set existingBook.CopiesAvailable = CopiesAvailable
  Set sc = existingBook.%Save()
  If $$$ISERR(sc) {
      Set fault = ..MakeStatusFault($$$FAULTSender, "Update problem", sc)
      Do ..ReturnFault(fault)
      Quit ""
  }
  Quit existingBook
}

Method DeleteBook(id As %String) As %String [ WebMethod ]
{
  Set sc = ##class(Library.Book).%DeleteId(id)
  If sc {
      Quit "true"
  } Else {
      Set fault=..MakeStatusFault($$$FAULTSender,"Delete problem",sc)
      Do ..ReturnFault(fault)
      Quit "false"
  }
}

}
