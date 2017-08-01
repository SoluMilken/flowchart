{smcl}
{* *! version 0.0.1 01aug2017}{...}
{* References: http://www.stata.com/manuals13/u18.pdf#u18.11Ado-files , http://www.stata.com/manuals13/u17.pdf }{...}
{vieweralsosee "[R] help" "help help "}{...}
{vieweralsosee "[R] texdoc" "help texdoc"}{...}
{viewerjumpto "Syntax" "flowchart##syntax"}{...}
{viewerjumpto "Description" "flowchart##description"}{...}
{viewerjumpto "Options" "flowchart##options"}{...}
{viewerjumpto "Remarks" "flowchart##remarks"}{...}
{viewerjumpto "Examples" "flowchart##examples"}{...}
{viewerjumpto "Troubleshooting" "flowchart##troubleshooting"}{...}
{viewerjumpto "Credits" "flowchart##credits"}{...}

{title:FLOWCHART Package}

{phang}
{bf:flowchart} {hline 2}  Use this command to generate a publication-quality Subject Disposition Flowchart 
Diagram in LaTeX format, similar in style to the ones used in the CONSORT 2010 Statement and STROBE Statement 
Reporting Guidelines. An example flowchart can be found here: http://www.texample.net/tikz/examples/consort-flowchart/ 

{marker syntax}{...}
{title:Syntax}


{p 8 17 2}
{cmdab:flo:wchart}
[{it:command}]
[{cmd:,}
{it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Commands}
{synopt:{opt i:nit}} {bf:init} using {it:filename.data} {hline 2} Initialize the diagram by specifying 
	a filename (or filename with filepath) where the data file to store variables will reside. This file 
	is used by the LaTeX datatool package to generate numerical data within the diagram.{p_end}
{synopt:{opt wri:terow}():} {bf:writerow}({it:rowname}): {it:center-block}, {it:left-block} {hline 2} Create 
	a new row in the diagram. A detailed explanation is below.{p_end}
{synopt:{opt con:nect}} {bf:connect} rowname_{it:blockorientation} rowname_{it:blockorientation}, [arrow({it:type})] {hline 2} 
	Draws arrows between the blocks across or between rows by specifying the rowname underscore block-orientation. 
	Options to change the arrow characteristics can be specified.{p_end}
{synopt:{opt fin:alize}} {bf:finalize}, input("{it:filename.texdoc}") output("{it:filename.tikz}") {hline 2} 
	Takes the prespecified texdoc syntax in {it:filename.texdoc} and writes into it the TikZ code into {it:filename.tikz} to be included in a manuscript's LaTeX document. {p_end}
{synopt:{opt setu:p}} {bf:setup}, [{it:update}] {hline 2} Installs texdoc and any other dependencies and 
	replaces the current flowchart installation. Alternatively, option [, {it:update}] can be specified to 
	update the flowchart package installation.{p_end}
{synopt:{opt deb:ug}} {bf:debug}, [{it:on off logreset tikz}] {hline 2} Turns on or off the debugging features 
	and produces a DebugLog.log that can be used when support is needed. Option {it:tikz} can be specified 
	to produce debugging strings in the final TikZ file.{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:filename} is the path to generate a new datatool file. See {help filename} for more detailed syntax information.{p_end}
{p 4 6 2}
{cmd:by} is not allowed; see {manhelp by D}.{p_end}



{p 8 17 2}
{cmdab:fl:owchart}
[{it:writerow}({it:rowname}):]
{it:line-triplets center-block orientation}
[{cmd:,}
{it:line-triplets left-block orientation}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Commands}
{synopt:{opt wri:terow}({it:rowname}):}Create a new row. The rowname must be alphanumeric. This rowname 
	is included in the blockname for each row's blocks. {p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{dlgtab:Overall}
{cmd:flowchart} is a command that generates a Subject Disposition Flowchart Diagram. 

	This is similar in style to the ones used in the CONSORT 2010 Statement Reporting Guidelines, in LaTeX format 
	using data from a dataset. This command uses the 'texdoc' command (written by Ben Jann). Install 
	it first by typing into Stata: 'net install texdoc, replace'. Or, type 'flowchart setup' after 
	installing the flowchart package to install texdoc and flowchart's ancillary files automatically.
	

{dlgtab:Initialization}
{phang}
{bf:flowchart} init using <{it:filename.data}>

	This command takes the filename of a text file where data variables can be written so that the 
	datatool package in LaTeX can be used to load the file specified to fill in all of the 
	\figvalues{variable_name} with the numbers specified in each line. (Variable names entered into 
	this LaTeX command entered must be unique and alphanumeric.)
	
	In LaTeX, place this in the preamble (the space between 
	\documentclass{article}... and \begin{document} ):
	
		% 	Figures, Diagrams, and Other Graphics
		\usepackage{tikz}		% TikZ Package - Generates graphics (i.e., flowcharts)
			\usetikzlibrary{shapes,arrows}
			\newcommand*{\h}{\hspace{5pt}}% For indentation
			\newcommand*{\hh}{\h\h}% Double indentation
		\usepackage{datatool}	% DataTool Package - Loads Subanalysis Data to generate flowchart
			\DTLsetseparator{ = }% Delimiter
	This will load the datatool and TikZ package.
	
{bf:flowchart set variable}, name([name_of_setting]) value([valuealphanumeric])

	This will write a variable to the variable file loaded by the datatool in LaTeX so that when the LaTeX
	document is compiled it will populate the LaTeX document with the variable's value. 
	Access this variable in a LaTeX document using \figvalue{variablename}
	To set layout variables:
		flowchart set layout, name(center_textwidth) value(12)
		flowchart set layout, name(left_textwidth) value(18)
		The name is prepended with set_ and written to the file.
	
{dlgtab:Rows (Boxes)}
{phang}
{bf:flowchart writerow(rowname): } 

	Format: flowchart writerow([Name_of_row]): [Block_Center], [Block_Left]
	
		The content within each block should be separated by a single comma (strings within a block can still 
		use a comma, it just has to be within double-quotes).
		
			The first block gets assigned the 'center' orientation and the second gets the 'left' orientation. 
			Each block can have several lines, and each line has to have a triplet of 3 fields which should be 
			separated by spaces.
			
			A single line is a triplet of these 3 fields: "variable_name" n# "Description of the variable 
			name and number."
			
			Limitations: Variable names must be unique and the numbers entered should be real numbers. 
			Descriptions must not contain curly braces (i.e., '{' or '}').
			
			In Stata, multiple triplets can be separated by a \\\ at the end of the line for readability.
			
		Each row can have 2 blocks: center and left. The center-block 
		appears on the left of the diagram and the left-block appears on the right of the diagram (note: this 
		can be confusing initially and must be learned).
		
		A blank block is a block with no lines or content (which won't be drawn in the final diagram) and should 
		have the special keyword 'flowchart_blank' to indicate to the program's parser internally that 
		there's no content for that block, otherwise the blocks will misalign and the .tex document will not 
		compile the TikZ picture.
		
	Format: [rowname_center] --> [rowname_left] - Connect a center block to a left block for horizontal 
		arrows across rows.
		* [rowname_center] --> [rowname_center] - Connect a center block to a center block for vertical 
			across within the same column for blocks in the center.
		* [rowname_left] --> [rowname_left] - Connect a left block to a left block for vertical across 
			within the same column for blocks on the left.
		* , arrow(angled) - This option makes the arrow make a 90 degree angle. Use this across a blank row.
		
{bf:Column Orientation}

	The sides of the diagram are initially counter-intuitive. Think of it like reading a chest x-ray: 
	when interpreting the x-ray the patient's left is on the right of the page and the patient's right 
	is on the left of the page -- the orientation being relative to a patient facing out of the plane 
	of the x-ray. Likewise, the column that is immediately to the left of the page as the center column 
	and the column that is immediately to the right of the page is the left column.

{dlgtab:Connections (Arrows)}
{phang}
{cmd:flowchart connect}

	Connect each row's block with an underscore and then the column-orientation corresponding to its 
	side in this manner.

{marker options}{...}
{title:Options}
{dlgtab:Main}
{phang}
{cmd:flowchart connect} [blockname_orientation1] [blockname_orientation2] {opt arrow(shape)} allows you to specify the type of arrow.


{marker remarks}{...}
{title:Remarks}
{pstd}
For detailed information on this command, see https://github.com/IsaacDodd/flowchart/ .

{title:Keywords}
	{bf:Flowchart_Blank}
		This keyword defines a blank block. Either the left or the center block can be set 
		to blank using this keyword before or after the comma respectively so that a box 
		doesn't appear on a given row.
		This can be of any casing (e.g., fLoWcHaRT_BLANK, flowchart_blank, or any combination) 
		as long as the keyword is spelled correctly, but for readibility it is wise to 
		use Flowchart_Blank.

		
{marker examples}{...}
{title:Examples}

See the very detailed examples in the Ancillary Files. Install them by typing into stata:

	net get flowchart, from(https://github.com/IsaacDodd/flowchart/)

	* |||||| EXAMPLE1: Dummy Row
	. flowchart writerow(rowname): "lblock1_line1" 46 "This is one line, \\ of a block." "lblock1_line2" 43 "This is another line, of a block" "lblock1_line3" 3 "This is another line, of a block", ///
		"rblock1_line1" 97 "This is one line, of a block." "rblock1_line2" 33 "This is another line, of a block" "rblock1_line3" 44 "This is another line, of a block"

	* |||||| EXAMPLE2: Row with No left-block
	. flowchart writerow(rowname): flowchart_blank, "rblock1_line1" 97 "This is one line, of a block." "rblock1_line2" 33 "This is another line, of a block" "rblock1_line3" 44 "This is another line, of a block"

	* |||||| EXAMPLE3: Row with No right-block
	. flowchart writerow(rowname): "lblock1_line1" 46 "This is one line, \\ of a block." "lblock1_line2" 43 "This is another line, of a block" "lblock1_line3" 3 "This is another line, of a block", flowchart_blank

{marker troubleshooting}{...}
{title:Troubleshooting}

Here is a list of known problems that can arise in using this program and their quick-fix solutions.

{phang}{cmd: STATA: unrecognized command:  Flowchart_Blank r(199);}{p_end}

	This is likely because you forgot to wrap a line where there is a blank.
	Here is an example:
		flowchart writerow(random): "randomized" 102 "Randomized", 
			Flowchart_Blank // Blank Row
	Here is how it is fixed:
		flowchart writerow(random): "randomized" 102 "Randomized", ///
			Flowchart_Blank // Blank Row
{phang}{cmd: TIKZ}{p_end}

	LATEX: Argument of \@dtl@lop@ff has an extra }. ...<filename of data file>.data"}

		This is likely because you tried to use the Flowchart_Blank keyword but actually 
		misspelled the 'Flowchart_Blank' keyword. Go back and edit the keyword and try again.
		
{phang}{cmd: TIKZ Package pgf Error}{p_end}

	Package pgf Error: No shape named <blockname_orientation> is known. \path (<blockname_orientation>)

		This is likely due to an error in using the 'flowchart connect' command where 
		you referred to a block that does not exist. If a row does not have an accompanying 
		block, whether left or center oriented, it cannot be connected to any other blocks. 
		Therefore, try reviewing the connection to determine if you may be connecting an 
		arrow to a block that is blank.

	flowchart init using C:\...\Filename With Spaces.data
	invalid 'With' 
	r(198);
		This error happens when you specify a filename that has spaces in it. Instead, put 
		the entire filepath in quotes:
	flowchart init using "C:\...\Filename With Spaces.data"
		Note: Specifying the entire path isn't necessary if you are using a working directory 
		with relative paths. See 'help filename' for an explanation of filenaming conventions.

		
	For problems not resolved through this list, please open an issue/bug on GitHub. When 
	opening a new issue, you can greatly speed up the issue resolution process by submitting 
	2 things:
		1. In Stata, type 'which flowchart'. Copy and paste the results into your issue. This 
		line specifies the exact version of the program you ran in case the problem was fixed 
		or introduced in a subsequent release.
		2. In your do file, go to the line or lines that are giving you trouble. Before those 
		lines, put 'flowchart debug on' and after those lines put 'flowchart debug off'. Then, 
		rerun your program. You should notice in your working directory a new file was created 
		called 'DebugLog.log'. Either copy and paste the content or attach it as a new file. 
		Be sure to first remove any sensitive directories that you would not want the public 
		to see since GitHub is an open source community.

{marker citations}{...}
{title:References & Bibliography}


1. Texdoc Command Use Based On: 
	Citation: Jann, Ben (2016 Nov 27). Creating LaTeX documents from within Stata using 
	texdoc. University of Bern Social Sciences Working Paper No. 14; The Stata Journal 
	16(2): 245-263. Reprinted with updates at 
	ftp://ftp.repec.org/opt/ReDIF/RePEc/bss/files/wp14/jann-2015-texdoc.pdf Retrieved on 
	July 28, 2017.
2. TikzPicture Diagram Code Based On: 
	 Citation: Willert, Morten Vejs (2011 Dec 31). "A CONSORT-style flowchart of a 
	 randomized controlled trial". TikZ Example (Texample.net). Retrieved from 
	 http://www.texample.net/tikz/examples/consort-flowchart/ 

{title:Credits & Acknowledgements}

	Credit to Ben Jann, whose texdoc package is a dependency in flowchart, and Morten 
	Willert, whose example of a flowchart diagram in TikZ was studied and used heavily 
	to generate similar flowcharts in this package.
	
	