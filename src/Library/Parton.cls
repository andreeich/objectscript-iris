Class Library.Patron Extends %Persistent
{

Property Name As %String [ Required ];

Property Email As %String [ Required ];

Property BorrowedItems As %List;

Method BorrowItem(item As Library.LibraryItem) As %Status
{
    If (item.GetAvailability()) {
        Set tSC = ..BorrowedItems.Insert(item)
        If $$$ISOK(tSC) {
            Set item.CopiesAvailable = item.CopiesAvailable - 1
            Set tSC = item.%Save()
        }
        Quit tSC
    }
    Quit $$$ERROR($$$GeneralError, "Item not available")
}

Method ReturnItem(item As Library.LibraryItem) As %Status
{
    Set tSC = $$$OK
    Try {
        Set item.CopiesAvailable = item.CopiesAvailable + 1
        Set tSC = item.%Save()
    } Catch ex {
        Set tSC = ex.AsStatus()
    }
    Quit tSC
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
