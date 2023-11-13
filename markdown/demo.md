

# Demo.md

This file will both showcase pandoc's markdown and the extensions in use on this template, 
as well as serve as a test for compatibility.

Full instructions come from the links below, this file is just for testing and quick referencing.

- [pandoc markdown](https://garrettgman.github.io/rmarkdown/authoring_pandoc_markdown.html)
- [pandoc crossref](https://lierdakil.github.io/pandoc-crossref/)

Some redundant features might not be showcased here.

Headers
=======

Lvl 2 header
------------

## Another lvl 2 header

### Lvl 3

#### Lvl 4

##### Lvl 5

###### Lvl 6

And text

# Block quotations

> Block quote. With
> 2 lines
>
> 1. This is a list inside a block quote.
> 2. Second item.

> Block quote. 
With 2 lines.

> 1. This is a list inside a block quote.
2. Second item.

> A block quote
> > Inside a block quote

> It is also possible
>> without the space

>     print("Hello world, this is some code")

# Verbatim/Code blocks

	print("With only tabs")
	def test():
		a += 1

~~~~~py
print("With tildes")
def test2():
	"""
	This allows attributes to be passed
	"""
	a += 2
~~~~~

```rs
fn main() {
    println!("With ```");
}
```

# Line blocks

| This preserves the 
| line breaks.
| 	Also indentation

# Lists

## Unordered

* one
* two
* three

* Loosely

* separated 

* elements

* An element 
formatted like a paragraph

* And a code block

        print("Hello code block")

* Now
    + nested
          - lists

## Ordered

#. Check your
	#. default
		#. numbering
			#. here

1) Numbers and )
   1) Nested
i. Roman numerals
    ii. Nested
(1) Double parenthesis
   (2) Nested

## Definitions

Some word
:	Its definition

Another

:	With a bigger
definition

	In 2 paragraphs
		print("And code")

Two
words
: Same definition

Word
~ With
~ Multiple
~ Meanings

## Examples

(@) An example (1)
(@) Another (2)
(@eg) referencable by `(@eg)`

In (@eg) we see how to reference an example

#Horizontal rules

***

---

___

# Tables

These examples are copied from [the rmarkdown guide](https://garrettgman.github.io/rmarkdown/authoring_pandoc_markdown.html#tables).

  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  Demonstration of simple table syntax. {#tbl:tbl1}

-------     ------ ----------   -------
     12     12        12             12
    123     123       123           123
      1     1          1              1
-------     ------ ----------   -------

-------------------------------------------------------------
 Centered   Default           Right Left
  Header    Aligned         Aligned Aligned
----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
-------------------------------------------------------------

Table: Here's the caption. It, too, may span
multiple lines.

----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
----------- ------- --------------- -------------------------

: Here's a multiline table without headers.

: Sample grid table.

+---------------+---------------+--------------------+
| Fruit         | Price         | Advantages         |
+===============+===============+====================+
| Bananas       | $1.34         | - built-in wrapper |
|               |               | - bright color     |
+---------------+---------------+--------------------+
| Oranges       | $2.10         | - cures scurvy     |
|               |               | - tasty            |
+---------------+---------------+--------------------+

| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
|   12  |  12  |    12   |    12  |
|  123  |  123 |   123   |   123  |
|    1  |    1 |     1   |     1  |

  : Demonstration of pipe table syntax.
  
fruit| price
-----|-----:
apple|2.05
pear|1.37
orange|3.09

| One | Two   |
|-----+-------|
| my  | table |
| is  | nice  |

# Backslash escapes

\*\\\_\ \\

## Inline formatting

## Smart punctuation

**REQUIRES `--smart` FLAG**

## Superscripts and subscripts

This ~text\ is\ subscripted~

This ^text\ is\ superscripted^

# Math

$c = \sqrt{a^2 + b^2}$

$$c = \sqrt{a^2 + b^2}$$

# Raw HTML

From [here](https://garrettgman.github.io/rmarkdown/authoring_pandoc_markdown.html#raw_html)

<table>
<tr>
<td>*one*</td>
<td>[a link](http://google.com)</td>
</tr>
</table>

# Raw TeX

From [here](https://garrettgman.github.io/rmarkdown/authoring_pandoc_markdown.html#raw_tex)

\begin{tabular}{|l|l|}\hline
Age & Frequency \\ \hline
18--25  & 15 \\
26--35  & 33 \\
36--45  & 22 \\ \hline
\end{tabular}

# Images

![An image](../figs/map.png "Alt text"){#fig:img1}

![Not in place]

[Not in place]: ../figs/map.png

Inline ![image](../figs/map.png "Something wrong")\

![Testing atributes](../figs/map.png){width=50%}

# Footnotes

Referencing this [^1] footnote [^longer]

[^1]: This is the note refecenced
[^longer]: Another footnote, this one is longer

    This is a second paragraph

And an inline note.^[these are easier to write but the text might be harder to read]

# Citations and References, crossref

To reference a chapter, like [Headers](#headers)

To reference a [figure](#fig:img1)

To reference a [table](#tbl:tbl1)

A raw tex citation \cite{3gpp.22.101}.

# Acronyms, pandacro

To add an acronym just add an entry under `acronyms` on the metadata

Then just type the acronym's id.

The id is the field that will be replaced with the short form throughout the text.

```yaml
acronyms:
    - id: id
      short: ID
      long: identifier
```
