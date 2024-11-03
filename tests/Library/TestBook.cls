Class Library.TestBook Extends %UnitTest.TestCase
{

Method TestCreateBook() As %Status
{
    Set book = ##class(Library.Book).%New()
    Set book.ID = "TEST" _ $INCREMENT(^TestBookCounter)
    Set book.Title = "Test Book"
    Set book.Author = "Test Author"
    Set book.PageCount = 200
    Set book.ISBN = "ISBN" _ $INCREMENT(^TestISBNCounter)
    Set book.PublicationDate = $ZDATEH("2023-06-01",3)
    Set book.CopiesAvailable = 5
    
    Set sc = book.%Save()
    Do $$$AssertStatusOK(sc, "Book should be saved successfully")
    
    // Verify saved book data
    Set loadedBook = ##class(Library.Book).%OpenId(book.%Id())
    Do $$$AssertEquals(loadedBook.Title, book.Title, "Title should match")
    Do $$$AssertEquals(loadedBook.Author, book.Author, "Author should match")
    Do $$$AssertEquals(loadedBook.PageCount, book.PageCount, "Page count should match")
    Do $$$AssertEquals(loadedBook.ISBN, book.ISBN, "ISBN should match")
    Do $$$AssertEquals(loadedBook.PublicationDate, book.PublicationDate, "Publication date should match")
    Do $$$AssertEquals(loadedBook.CopiesAvailable, book.CopiesAvailable, "Copies available should match")
    
    Quit $$$OK
}

Method TestUniqueProperties() As %Status
{
    // Create first book
    Set book1 = ##class(Library.Book).%New()
    Set book1.ID = "TEST" _ $INCREMENT(^TestBookCounter)
    Set book1.Title = "Unique Book"
    Set book1.Author = "Unique Author"
    Set book1.PageCount = 300
    Set book1.ISBN = "ISBN" _ $INCREMENT(^TestISBNCounter)
    Set book1.PublicationDate = $ZDATEH("2023-06-02",3)
    Set book1.CopiesAvailable = 3
    
    Set sc = book1.%Save()
    Do $$$AssertStatusOK(sc, "First book should be saved successfully")
    
    // Create second book with same ISBN
    Set book2 = ##class(Library.Book).%New()
    Set book2.ID = "TEST" _ $INCREMENT(^TestBookCounter)
    Set book2.Title = "Another Book"
    Set book2.Author = "Another Author"
    Set book2.PageCount = 250
    Set book2.ISBN = book1.ISBN  // Same ISBN as book1
    Set book2.PublicationDate = $ZDATEH("2023-06-03",3)
    Set book2.CopiesAvailable = 2
    
    Set sc = book2.%Save()
    Do $$$AssertStatusNotOK(sc, "Second book should not be saved due to duplicate ISBN")
    
    Quit $$$OK
}

Method TestRequiredProperties() As %Status
{
    Set book = ##class(Library.Book).%New()
    Set book.ID = "TEST" _ $INCREMENT(^TestBookCounter)
    // Intentionally not setting Title, which is required
    Set book.Author = "Required Author"
    Set book.PageCount = 150
    Set book.ISBN = "1122334455667"
    Set book.PublicationDate = $ZDATEH("2023-06-04",3)
    Set book.CopiesAvailable = 1
    
    Set sc = book.%Save()
    Do $$$AssertStatusNotOK(sc, "Book should not be saved without required Title")
    
    Quit $$$OK
}

Method TestDeleteObjectWithChildren() As %Status
{
    // Create a library
    Set library = ##class(Library.Library).%New()
    Set library.Name = "Test Library"
    Set library.Address = "123 Main St"
    
    Set librarian = ##class(Library.Librarian).%New()
    Set librarian.Name = "Test librarian"
    Set librarian.Position = "Librarian"
    Do library.Staff.Insert(librarian)
    
    Set sc = library.%Save()
    Do $$$AssertStatusOK(sc, "Library should be saved successfully")
    
    // Create a book and add it to the library
    Set book = ##class(Library.Book).%New()
    Set book.ID = "TEST" _ $INCREMENT(^TestBookCounter)
    Set book.Title = "Test Book"
    Set book.Author = "Test Author"
    Set book.PageCount = 200
    Set book.ISBN = "ISBN" _ $INCREMENT(^TestISBNCounter)
    Set book.PublicationDate = $ZDATEH("2023-06-01",3)
    Set book.CopiesAvailable = 5
    Do library.Inventory.Insert(book)
    
    Set sc = library.%Save()
    Do $$$AssertStatusOK(sc, "Library should be updated successfully")
    
    // Delete the library
    Set sc = library.%Delete()
    Do $$$AssertStatusOK(sc, "Library should be deleted successfully")
    
    // Verify book is deleted along with the library
    Set deletedBook = ##class(Library.Book).%OpenId(book.%Id())
    Do $$$AssertStatusNotOK(deletedBook, "Book should be deleted along with the library")
    
    Quit $$$OK
}

Method TestDeleteBook() As %Status
{
    Set book = ##class(Library.Book).%New()
    Set book.ID = "TEST" _ $INCREMENT(^TestBookCounter)
    Set book.Title = "Test Book"
    Set book.Author = "Test Author"
    Set book.PageCount = 200
    Set book.ISBN = "ISBN" _ $INCREMENT(^TestISBNCounter)
    Set book.PublicationDate = $ZDATEH("2023-06-01",3)
    Set book.CopiesAvailable = 5
    
    Set sc = book.%Save()
    Do $$$AssertStatusOK(sc, "Book should be saved successfully")
    
    // Verify book is deleted
    Set deletedBook = ##class(Library.Book).%OpenId(book.%Id())
    Do $$$AssertStatusNotOK(deletedBook, "Book should be deleted")
    
    Quit $$$OK
}

}
