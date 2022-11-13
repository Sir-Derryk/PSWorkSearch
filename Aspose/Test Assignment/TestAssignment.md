# GroupDocs.Parser

## General description

GroupDocs.Parser is an application programming interface (API) to extract data from documents. This section contains a  description of the main GroupDocs.Parser features.

## Input data

The API proceeds documents in different formats, including images. For a format list, see [Supported Document Formats](https://docs.groupdocs.com/parser/net/supported-document-formats/).

## Processing results

A result of the document processing may be as follows:

Extracted data|Description|Methods
---|---|---
Plain text|Text is extracted without preserving the format and structure. A simplified mode of operation is available that reduces extraction accuracy but improves performance. For details, see [Extract text from documents](https://docs.groupdocs.com/parser/net/extract-text-from-documents/).|[GetText](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/gettext/)
Formatted text|Extracted text is formatted. The result can be presented as plain text or using HTML or Markdown markup languages. For details, see [Extract formatteed text from documents](https://docs.groupdocs.com/parser/net/extract-formatted-text-from-documents/).|[GetFormattedText](https://apireference.groupdocs.com/net/parser/groupdocs.parser/parser/methods/getformattedtext)
Structured text|Typically, text contains paragraphs, headings, numbered and bulleted lists, and other elements. In this mode, GroupDocs.Parser parses the structure of the document and returns the result in XML format. For details, see [Extract text structure](https://docs.groupdocs.com/parser/net/extract-text-structure/).|[GetDocumentStructure](GetStructure)
Specific information|GroupDocs.Parser allows parsing documents according to user-defined templates to extract specific information such as invoice number, address etc. For details, see [Working with templates](https://docs.groupdocs.com/parser/net/working-with-templates/).|[ParseByTemplate](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/parsebytemplate/).
PDF form information|GroupDocs.Parser allows parsing filled PDF forms. For details, see [Extract data from PDF forms](https://docs.groupdocs.com/parser/net/extract-data-from-pdf-forms/)|[ParseForm](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/parseform/)
Document or file entities|GroupsDocs.Parser allows extracting various parts of document or file depending of its format. For example, it can extract barcodes and/or QR-codes, links, images ets. For details, see [https://docs.groupdocs.com/parser/net/basic-usage/](https://docs.groupdocs.com/parser/net/basic-usage/).|[GetBarcodes](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/getbarcodes/), [GetContainer](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/getcontainer/), [GetHighlight](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/gethighlight/), [GetHyperlinks](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/gethyperlinks/), [GetImages](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/getimages/), [GetTables](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/gettables/), [GetTextAreas](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/gettextareas/), [GetToc](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/gettoc/)
Document or file information|GroupDocs.Parser provides additional information about file ad documents, including document metadata. For details, see [https://docs.groupdocs.com/parser/net/basic-usage/](https://docs.groupdocs.com/parser/net/basic-usage/). |[GetMetadata](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/getmetadata/), [GetDocumentInfo](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/getdocumentinfo/), [GetFileInfo](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/getfilenifo/)
Search results|GroupDocs.Parser allows searching the document using keywords or regular expression. For details, see [Search text](https://docs.groupdocs.com/parser/net/search-text/).|[Search](https://reference.groupdocs.com/parser/net/groupdocs.parser/parser/search/)

## See also

For the GroupDocs.Parser API references see [Parser](https://reference.groupdocs.com/parser/ru/net/).

# Extract formatted text from documents

## Overview

If plain text is not suitable and you need to keep the text formatting, GroupDocs.Parser allows extracting formatted text from documents.

To keep the text formatting, GroupDocs.Parser uses HTML tags, Markdown syntax, or integrated ASCII formatting symbols for tables, lists, etc.

## Instructions

To extract a formatted text from documents, call the [GetFormattedText](https://apireference.groupdocs.com/net/parser/groupdocs.parser/parser/methods/getformattedtext) method:

    TextReader GetFormattedText(FormattedTextOptions options);

The method returns an instance of the TextReader class with an extracted text. [FormattedTextOptions](https://apireference.groupdocs.com/net/parser/groupdocs.parser.options/formattedtextoptions) has the following constructor:

    FormattedTextOptions(FormattedTextMode mode)

For details, see [FormattedTextMode](https://apireference.groupdocs.com/net/parser/groupdocs.parser.options/formattedtextmode).

To extract an HTML formatted text from the document, follow these steps:

1. Instantiate Parser object for the initial document;
2. Instantiate FormattedTextOptions with HTML text mode;
3. Call the GetFormattedText method and obtain the TextReader object (reader);
4. Check if the reader is not null (formatted text extraction is supported for the document);
5. Read a text from the reader.

## Example

The following example shows how to extract a document text as HTML text:

    // Create an instance of Parser class
    using (Parser parser = new Parser(filePath))
    {
        // Extract a formatted text into the reader
        using (TextReader reader = parser.GetFormattedText(new FormattedTextOptions(FormattedTextMode.Html)))
        {
            // Print a formatted text from the document
            // If formatted text extraction isn't supported, a reader is null
            Console.WriteLine(reader == null ? "Formatted text extraction isn't supported" : reader.ReadToEnd());
        }
    }
