% FortySecondsCV LaTeX class 
% Copyright © 2019 René Wirnata <rene.wirnata@pandascience.net>
% Licensed under the 3-Clause BSD License. See LICENSE file for details.
%
% Attributions
% ------------
% * fortysecondscv is based on the twentysecondcv class by Carmine Spagnuolo 
%   (cspagnuolo@unisa.it), released under the MIT license and available under
%   https://github.com/spagnuolocarmine/TwentySecondsCurriculumVitae-LaTex
% * further attributions are indicated immediately before corresponding code


%-------------------------------------------------------------------------------
%                           CLASS NAME AND VERSION
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fortysecondscv}[2019/03/17 CV class]


%-------------------------------------------------------------------------------
%                               PROCESS OPTIONS
%-------------------------------------------------------------------------------
%% load some required packages first
% for easy color definitions; provides \definecolor; load before background pkg
\RequirePackage[dvipsnames, svgnames, x11names]{xcolor}
% for positioning text within the side column | use showboxes for visible frame
\RequirePackage[absolute,overlay]{textpos}
% provides key-value class options via \DeclareOptionX
\RequirePackage{xkeyval}
% enable simple math like +/- etc. on lengths
\RequirePackage{calc}
% change page margins
\RequirePackage[
	nohead,
	nofoot,
	nomarginpar,
]{geometry}

% pre-define some colors the user can choose from
\definecolor{cvblue}{HTML}{0E5484}
\definecolor{cvgreen}{HTML}{007170}
\definecolor{cvred}{HTML}{8B0000}
\definecolor{cvsidecolor}{HTML}{E7E7E7}
\definecolor{cvsectioncolor}{HTML}{0395DE}
\definecolor{cvsubsectioncolor}{HTML}{4D4D4D}
% set default values
\colorlet{maincolor}{cvblue}
\colorlet{sidecolor}{cvsidecolor}
\colorlet{sectioncolor}{cvsectioncolor}
\colorlet{subsectioncolor}{cvsubsectioncolor}
% colors for document body (right column)
% let user define main color
\DeclareOptionX{maincolor}{\colorlet{maincolor}{#1}}
\DeclareOptionX{sidecolor}{\colorlet{sidecolor}{#1}}
\DeclareOptionX{sectioncolor}{\colorlet{sectioncolor}{#1}}
\DeclareOptionX{subsectioncolor}{\colorlet{subsectioncolor}{#1}}

%	set page margins
\newlength\sidebarwidth%
\newlength\topbottommargin%
\newlength\leftrightmargin%
\newlength\sidebartextwidth
% default values
\setlength{\sidebarwidth}{0.36\paperwidth}
\setlength{\topbottommargin}{0.02\paperheight}
\setlength{\leftrightmargin}{0.02\paperwidth}
% user overwrites
\DeclareOptionX{sidebarwidth}{\setlength{\sidebarwidth}{#1}}
\DeclareOptionX{topbottommargin}{\setlength{\topbottommargin}{#1}}
\DeclareOptionX{leftrightmargin}{\setlength{\leftrightmargin}{#1}}

% show sidebar and page margins
\DeclareOptionX{showframes}{
  \geometry{showframe}
  \TPoptions{showboxes=true}
}

% pass further options to base class and load it
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptionsX\relax
\LoadClass{article}

% compute "inner" margin of sidebar automatically;
% must come after \sidebarwidth and \leftrightmargin possibly changed by user
\setlength{\sidebartextwidth}{\sidebarwidth - 2\leftrightmargin}

% let geometry package perform the changes;
% must come after loading the base class prevent overwriting
\geometry{
	top=\topbottommargin,
	bottom=\topbottommargin,
	left=\sidebarwidth + \leftrightmargin,
	right=\leftrightmargin,
}

%-------------------------------------------------------------------------------
%                              REQUIRED PACKAGES
%-------------------------------------------------------------------------------
% font configuration
\RequirePackage[sfdefault]{ClearSans}

% use as workaround for spacing problem when TikZ picture is not in paragraph;
% details: https://tex.stackexchange.com/a/435790
\RequirePackage{background}

% for easy section style definitions
\RequirePackage{titlesec}

% loads graphicx, provides align=c option for vertical alignment w.r.t. text
\RequirePackage{graphbox} 

% pictures, icons and drawings
\RequirePackage{ifxetex}
\ifxetex
	\RequirePackage{fontawesome5}
\else
	\RequirePackage{fontawesome}
\fi
\RequirePackage{tikz}
\usetikzlibrary{arrows, backgrounds}

% provides \xrfill for horizontal rules
\RequirePackage{xhfill}

% provides basic conditional expressions
\RequirePackage{ifthen}

% provides \ifnumgreater{<int expr.>}{<int expr.>}{<true>}{<false>} 
% and \apptocmd{<command>}{<code>}{<success>}{<failure>}
\RequirePackage{etoolbox}

% enable links
\RequirePackage[hidelinks]{hyperref}


%-------------------------------------------------------------------------------
%                          DERIVED COLOR DEFINITIONS
%-------------------------------------------------------------------------------
% profile section color (sidebar/left column)
\colorlet{pseccolor}{maincolor!90}
% color used for all icon arguments
\colorlet{iconcolor}{maincolor!90}

% color definitions for TikZ drawings
\colorlet{wheelchartlabelcolor}{black}
\colorlet{wheeltextcolor}{black!80!white}
% color of unfilld skill points / bar / chart label
\colorlet{skillbg}{black!25}


%-------------------------------------------------------------------------------
%                      GLOBAL LAYOUT AND HEADINGS STYLE
%-------------------------------------------------------------------------------
% remove headers and footers
\pagestyle{empty}

% globally disable paragraph indentation
\setlength{\parindent}{0pt}

% set space between paragraphs
% \setlength{\parskip}{1ex}

% creates a rule after some text using remaining line width
% usage: \xrfill[<raise>]{<width>}
\newcommand*{\sectionline}[1]{#1~\xrfill[.5ex]{1pt}[pseccolor]} 

% section style for cv table headings in right column
% \titleformat{<command>}[<shape>]{<format>}{<label>}{<sep>}{<before>}[<after>]
\newcommand*{\cvsection}[1]{\section*{#1}}
\titleformat{\section}%
	{\color{sectioncolor}\normalfont\bfseries\LARGE}{}{0pt}{}

% grey subsection style for right column
\titleformat{\subsection}%
	{\color{subsectioncolor}\normalfont\large}{}{0pt}{}

% abuse subsubsection as profilesection in left column
\newcommand*{\profilesection}[1]{\subsubsection*{#1}}
\titleformat{\subsubsection}
	{\color{pseccolor}\normalfont\huge}{}{0pt}{\color{pseccolor}\sectionline}
% set spaces before and after profilesections: <left><before><after>
% "starred version kills the indentation of the paragraph following the title"
\titlespacing*{\subsubsection}{0pt}{1ex}{1ex}


%-------------------------------------------------------------------------------
%                              SIDEBAR ELEMENTS
%-------------------------------------------------------------------------------
% save user definition for personal information as makro that can be used later
\newcommand*{\cvprofilepic}[1]{\renewcommand{\cvprofilepic}{#1}}
\newcommand*{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand*{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand*{\cvbirthday}[1]{\renewcommand{\cvbirthday}{#1}}
\newcommand*{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand*{\cvphone}[1]{\renewcommand{\cvphone}{#1}}
\newcommand*{\cvsite}[1]{\renewcommand{\cvsite}{\href{#1}{#1}}}
\newcommand*{\cvgit}[1]{\renewcommand{\cvgit}{\href{#1}{#1}}}
\newcommand*{\cvmail}[1]{\renewcommand{\cvmail}{\href{mailto:#1}{#1}}}
\newcommand*{\cvkey}[2]{\renewcommand{\cvkey}{%
	\href{https://keyserver.ubuntu.com/pks/lookup?search=#2\&op=vindex\&fingerprint=on}{#1}%
}}

% TODO find a cleaner solution for consistent spacing
\newcommand{\nameandjob}{%
	{\Huge\color{maincolor}\cvname}\par%
	\setlength{\parskip}{2ex}
	{\Large\color{black!80}\cvjobtitle}\par%
	\setlength{\parskip}{1ex}
}

\newcommand{\profileroundedcorners}{%
	\begin{figure}\centering
		% see TikZ/pgf v3.1.1 manual §2.11 (clipping), §14.5 (rounded corners),
		% §12 (scopes), §13.2 (coordinate systems)
		\begin{tikzpicture}[x=0.93\sidebartextwidth, y=0.90\sidebartextwidth]
			\begin{scope}
			\path[clip]
				(0, 0) [sharp corners] -- 
				(0, 1) [rounded corners=0.15\sidebartextwidth] -- 
				(1, 1) [sharp corners] --
				(1, 0) [rounded corners=0.15\sidebartextwidth] -- cycle;
			\node[anchor=south west, inner sep=0pt] (profilepic) at (0, 0)
				{\includegraphics[width=\sidebartextwidth]{\cvprofilepic}};
			\end{scope}
			\begin{scope}
			\draw	[line width=0.02\sidebartextwidth, color=iconcolor]
				(0, 0) [sharp corners] -- 
				(0, 1) [rounded corners=0.15\sidebartextwidth] -- 
				(1, 1) [sharp corners] --
				(1, 0) [rounded corners=0.15\sidebartextwidth] -- cycle;
			\end{scope}
		\end{tikzpicture}
	\end{figure}
}


% use table with 2 columns, optional argument is space between columns
\newenvironment{personal}[1][1em]%
{%
	\renewcommand{\arraystretch}{1.6}% increase linespacing in tables; default=1
	\begin{tabular}{p{2em} @{\hskip #1} p{14em}}%
}{%
	\end{tabular}%
}

% table with personal information on top sidebar on first page
\newcommand{\personaltable}{%
	\begin{personal}[0.6em]
		\circleicon{\faInfo}     & \cvbirthday \\
		\circleicon{\faEnvelope} & \cvaddress \\
		\circleicon{\faPhone}    & \cvphone \\
		%\circleicon{\faGlobe}    & \cvsite \\
        \circleicon{\faGit}      & \cvgit \\
		\circleicon{\faAt}       & \cvmail \\
		\circleicon{\faKey}      & \cvkey \\
	\end{personal}
}

% icon style for personal information
\newcommand*\circleicon[1]{%
	\tikz[baseline = (char.base)]{%
		\node[%
			shape=circle,%
			draw,%
			inner sep=1pt,%
			fill=iconcolor,%
			maincolor,%
			text=white,%
			minimum size=1.7em%
		] (char) {#1};%
	}%
}

% make sure about me text stays in textbox frame
\newcommand{\aboutme}[1]{\parbox[b]{\linewidth}{#1}}

% uniform icon style for all cvskill icons, e.g. flags or fontawesome icons
\newcommand{\cvicon}[1]{\makebox[1em]{\color{iconcolor} #1}}
\newcommand{\flag}[1]{\includegraphics[align=c, width=1em]{#1}}

% \pointskill[<indent>]{<icon>}{<description>}{<level>} creates 
% | [indent] [icon]  description  \hfill  ● ● ● ○ ○ | 
% -- inspired by arravc.cls by LianTze Lim: https://github.com/liantze/AltaCV
\newcommand{\pointskill}[4][0em]{%
	\hspace{#1} \cvicon{#2} ~ #3 \hfill%
	\foreach \x in {1,...,5}{%
		\space%
		{\ifnumgreater{\x}{#4}{\color{skillbg}}{\color{iconcolor}}% from etoolbox
		% don't use totalheight; see https://tex.stackexchange.com/a/41014
		\raisebox{0.5\height-0.4ex}{\scriptsize\faCircle}%
		}
	}\par%
}

\newcommand{\barskill}[3]{ 
	% remove 1pt in width to prevent overfull box warnings
	\begin{tikzpicture}[x=\sidebartextwidth-1pt, y=2ex]
			\draw[fill, skillbg, rounded corners=0.5em] 
				(0, 0) rectangle (1, 1);
			\draw[fill, iconcolor!70, rounded corners=0.5em] 
				(0, 0) rectangle (#3/100, 1);
			\node[above right] at (0, 1) {\cvicon{#1} ~ #2};
	\end{tikzpicture}
	\par
}

% \skill[<indent>]{<icon>}{<description>} creates in sidebar
% | [indent] [icon]  some longer skill description  |
\newcommand{\skill}[3][0em]{\hspace{#1} \cvicon{#2} ~ #3 \hfill \par}

% label for wheel charts
\newcommand{\chartlabel}[1]{%
	\begin{tikzpicture}
  	\node[
	  	fill=skillbg!25, % interior color
	  	anchor=base,
	  	draw=skillbg, % line color
	  	rounded corners,
	  	inner xsep=1ex, % distance from left/right border to text
	  	inner ysep=0.75ex, % distance top/bottom border to text
	  	text height=1.5ex, % align text vertically in box (at least as resulting
	  	text depth=.25ex   % effect)
  	]{#1};%
	\end{tikzpicture}
  }
  
\newcommand{\chartlabell}[1]{%
	\begin{tikzpicture}
	\end{tikzpicture}
  }
\newenvironment{memberships}
	{\begin{tabular*}{\textwidth}{l@{\hskip 2em}l}}
	{\end{tabular*}}

\newcommand{\membership}[2]{
	\includegraphics[align=c,width=4em]{#1}&\parbox[c]{\linewidth-6em}{#2}\\[3ex]
}

% adapted from https://tex.stackexchange.com/a/82729
\newcommand{\wheelchart}[4][-90]{%
    \def\outerradius{#2}%
    \def\innerradius{#3}%
    % Calculate total
    \pgfmathsetmacro{\totalnum}{0}%
    \foreach\value/\colour/\name in {#4} {%
        \pgfmathparse{\value+\totalnum}%
        \global\let\totalnum=\pgfmathresult%
    }%
    \begin{tikzpicture}

      % Calculate the thickness and the middle line of the wheel
      \pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
      \pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}

      % Rotate so we start from the top
      \begin{scope}[rotate=#1, on background layer]
      % Loop through each value set. \cumnum keeps track of where we are in the
      % wheel                
      \pgfmathsetmacro{\cumnum}{0}
      \foreach \value/\width/\colour/\name in {#4} {
            \pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

            % Calculate the percent value
            \pgfmathsetmacro{\percentage}{\value/\totalnum*100}
            % Calculate the mid angle of the colour segments to place the labels
            \pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

            % This is necessary for the labels to align nicely
            \pgfmathparse{
               (-\midangle>180?"west":"east")
            } \edef\textanchor{\pgfmathresult}
            \pgfmathparse{
               (-\midangle>180?"flush left":"flush right")
            } \edef\textalign{\pgfmathresult}
            \pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

            % Draw the color segments. Somehow, the \midrow units got lost, so
            % we add 'pt' at the end. Not nice...
            \filldraw[draw=white,fill=\colour] 
	            (-\cumnum:\outerradius) 
	            arc (-\cumnum:-(\newcumnum):\outerradius) 
	            -- (-\newcumnum:\innerradius) 
	            arc (-\newcumnum:-(\cumnum):\innerradius) 
	            -- cycle;

            % Draw the data labels
            \draw [*-,thin,wheelchartlabelcolor] node [append after command={
		          (\midangle:\midradius pt) -- 
 	  	        (\midangle:\outerradius + 1ex) -- 
		          (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [
		          xshift=\labelshiftdir*0.5cm,inner sep=1ex, 
		          outer sep=0pt, 
		          text width=\width,
		          anchor=\textanchor,
		          align=\textalign,
		          font=\small,
		          text=wheeltextcolor
	          ]{\name};
            % Set the old cumulated angle to the new value
            \global\let\cumnum=\newcumnum
        }
      \end{scope}
    \end{tikzpicture}\par
}

\newcommand{\cvsignature}{
	\vfill
	{\large\bfseries\color{maincolor!70}\today \hfill \cvname}
}


%-------------------------------------------------------------------------------
%                               SIDEBAR LAYOUT
%-------------------------------------------------------------------------------
% draw sidebar background on every page
\backgroundsetup{
	opacity=1, 
	scale=1, 
	angle=0, 
	position=current page.north west,
	contents={%
		\begin{tikzpicture}[remember picture, overlay]
   		\node[
   			rectangle,
   			fill=sidecolor,
   			anchor=north west,
   			minimum width=\sidebarwidth,
   			minimum height=\paperheight,
			]{};% (frontsidebar) at (current page.north west){};
		\end{tikzpicture}
	}
}

% use textpos to position textblock within TikZ background; we have to use
% the starred version for absolute values here, b/c we use \pagewidth directly
% instead of \setlength{\TPHorizModule}{<dimen>}, which seems to be "absolute" 
% as opposed to "relative" - strange but true.
\newenvironment{sidebar}%
	{\begin{textblock*}{\sidebartextwidth}(\leftrightmargin, \topbottommargin)}%
	{\end{textblock*}}

% provide user interface for easily adding new sections in side bars
% default: empty sidebar
\newcommand{\frontsidebar}{}
\newcommand{\backsidebar}{}
\newcommand{\addtofrontsidebar}[1]{\apptocmd{\frontsidebar}{#1}{}{}}
\newcommand{\addtobacksidebar}[1]{\apptocmd{\backsidebar}{#1}{}{}}

\newcommand{\makefrontsidebar}{%
	\begin{sidebar}
		% most sidebar commands end with \par; increase space between them
		% \setlength{\parskip}{1ex}

		% insert profile picture
		% \profileroundedcorners
		% \vspace{1ex}

		% name and job
		\nameandjob

		% personal information
		%\vspace*{0.5em}
		\personaltable

		% % user definitions
		\frontsidebar
		\backsidebar
	\end{sidebar}
}

\newcommand{\makebacksidebar}{%
 	\begin{sidebar}
		% begin with name instead of picture
		% \nameandjob
		
		% make sure there is no space at top, but after cvjob
		\setlength{\parskip}{1ex}
		% user definitions
		\backsidebar
	\end{sidebar}
}


%-------------------------------------------------------------------------------
%                              LIST ENVIRONMENTS
%-------------------------------------------------------------------------------
% reduce space between table columns to minimum
\setlength{\tabcolsep}{0pt}

% cv list environment --> table, left aligned, width=textwidth
% tabular starred version adds space to make table as wide as \textwidth here
\newenvironment{cvtable}%
	{\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}}%
	{\end{tabular*}}

% | <keyword>      <one-line description>            |
% use parbox if text needs to use multiple lines
\newcommand{\cvitemshort}[2]{%
	\parbox[t]{0.17\textwidth}{\raggedright #1}
  & \parbox[t]{0.81\textwidth}{#2} \\}

% | <date>         <bold-title>  \hfill  <location>  |
% |                <longer description>              |
% or, if description is empty:
% | <date>         <title>       \hfill  <location>  |
\newcommand{\cvitem}[4]{%
	\parbox[t]{0.17\textwidth}{\raggedright #1} &%
	\parbox[t]{0.81\textwidth}{%
		\if\relax\detokenize{#4}\relax%
			\parbox[t]{\linewidth-\widthof{#3}-1em}{\raggedright #2}%
  		\hfill {\footnotesize#3}%
		\else%
			\textbf{#2} \hfill {\footnotesize#3} \\ #4\vspace{\parsep}%
		\fi%
	}\\
}

% EOF - fortysecondscv.cls
