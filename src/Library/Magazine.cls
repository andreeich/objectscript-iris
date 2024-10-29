Class Library.Magazine Extends Library.LibraryItem
{

Property Publisher As %String [ Required ];

Property IssueNumber As %Integer [ Required ];

Index IssueIndex On (Publisher, IssueNumber) [ Unique ];

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
