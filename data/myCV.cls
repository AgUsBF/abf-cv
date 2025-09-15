\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myCV}[myCV]

%-------------------------------------------------------------------------------
%                            BASE CLASS DEFINITIONS
%-------------------------------------------------------------------------------
\RequirePackage[dvipsnames, svgnames, x11names]{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{xkeyval}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage[nohead, nofoot, nomarginpar,]{geometry}

% pre-define some colors the user can choose from
\definecolor{cvblue}{HTML}{0E5484}
\definecolor{cvsidecolor}{HTML}{E7E7E7}
\definecolor{cvsectioncolor}{HTML}{0395DE}
\definecolor{cvsubsectioncolor}{HTML}{4D4D4D}
% set default values
\colorlet{maincolor}{cvblue}
\colorlet{sidecolor}{cvsidecolor}
\colorlet{sectioncolor}{cvsectioncolor}
\colorlet{subsectioncolor}{cvsubsectioncolor}
\colorlet{itemtextcolor}{black!90}
% colors for document body (right column)
\DeclareOptionX{maincolor}{\colorlet{maincolor}{#1}}
\DeclareOptionX{sidecolor}{\colorlet{sidecolor}{#1}}
\DeclareOptionX{sectioncolor}{\colorlet{sectioncolor}{#1}}
\DeclareOptionX{subsectioncolor}{\colorlet{subsectioncolor}{#1}}
\DeclareOptionX{itemtextcolor}{\colorlet{itemtextcolor}{#1}}

% set page margins
\newlength\sidebarwidth
\newlength\topbottommargin
\newlength\leftrightmargin
\newlength\sidebartextwidth
% default values
\setlength{\sidebarwidth}{0.34\paperwidth}
\setlength{\topbottommargin}{0.02\paperheight}
\setlength{\leftrightmargin}{0.02\paperwidth}
% user overwrites
\DeclareOptionX{sidebarwidth}{\setlength{\sidebarwidth}{#1}}
\DeclareOptionX{topbottommargin}{\setlength{\topbottommargin}{#1}}
\DeclareOptionX{leftrightmargin}{\setlength{\leftrightmargin}{#1}}

% profile picture settings
\newlength\profilepicsize
\setlength{\profilepicsize}{0.7\sidebarwidth}
\DeclareOptionX{profilepicsize}{\setlength{\profilepicsize}{#1}}
\newlength\profilepicborderwidth
\setlength{\profilepicborderwidth}{3.5pt}
\DeclareOptionX{profilepicborderwidth}{\setlength{\profilepicborderwidth}{#1}}
\newcommand*{\profilepicstyle}{}
\DeclareOptionX{profilepicstyle}{\renewcommand{\profilepicstyle}{#1}}
\newcommand*{\profilepiczoom}{}
\DeclareOptionX{profilepiczoom}{\renewcommand{\profilepiczoom}{#1}}
\newlength\profilepicxshift
\setlength{\profilepicxshift}{0mm}
\DeclareOptionX{profilepicxshift}{\setlength{\profilepicxshift}{#1}}
\newlength\profilepicyshift
\setlength{\profilepicyshift}{0mm}
\DeclareOptionX{profilepicyshift}{\setlength{\profilepicyshift}{#1}}
\newlength\profilepicrounding
\setlength{\profilepicrounding}{0.15\sidebarwidth}
\DeclareOptionX{profilepicrounding}{\setlength{\profilepicrounding}{#1}}

% show sidebar and page margins
\newtoggle{tshowframes}
\togglefalse{tshowframes}
\DeclareOptionX{showframes}{
	\geometry{showframe}
	\TPoptions{showboxes=true}
	\toggletrue{tshowframes}
	\AtBeginDocument{\apptocmd{\personaldata}{\hline}{}{}}
}

% draw vertical guideline
\newcommand{\plotvline}{}
\DeclareOptionX{vline}{
	\renewcommand{\plotvline}{
		\draw [thick, red, opacity=0.7]
		(\leftrightmargin + #1, 0) -- (\leftrightmargin + #1, -\paperheight);
	}
}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptionsX\relax
\LoadClass{article}

\setlength{\sidebartextwidth}{\sidebarwidth - 2\leftrightmargin}

\geometry{
	top=\topbottommargin,
	bottom=\topbottommargin,
	left=\sidebarwidth + \leftrightmargin,
	right=\leftrightmargin,
}

%-------------------------------------------------------------------------------
%                              REQUIRED PACKAGES
%-------------------------------------------------------------------------------
\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[texcoord]{eso-pic}
\RequirePackage{titlesec}
\RequirePackage{graphbox}
\RequirePackage{tabularx}
\RequirePackage{tikz}
\usetikzlibrary{arrows, backgrounds}
\RequirePackage{xhfill}
\RequirePackage{ifthen}
\RequirePackage{xparse}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{ifluatex}
\RequirePackage{ifxetex}
\newif\ifxetexorluatex

\ifxetex
	\xetexorluatextrue
\else
	\ifluatex
		\xetexorluatextrue
	\else
		\xetexorluatexfalse
	\fi
\fi

\ifxetexorluatex
	\RequirePackage{fontawesome5}
	\RequirePackage{academicons}
\else
	\RequirePackage{fontawesome}
\fi

%-------------------------------------------------------------------------------
%                          DERIVED COLOR DEFINITIONS
%-------------------------------------------------------------------------------
% profile section color (sidebar/left column)
\colorlet{pseccolor}{maincolor!90}
% color used for all icon arguments
\colorlet{iconcolor}{maincolor!90}
% color definitions for TikZ drawings
\colorlet{skillbg}{black!25}

%-------------------------------------------------------------------------------
%                      GLOBAL LAYOUT AND HEADINGS STYLE
%-------------------------------------------------------------------------------
% remove headers and footers
\pagestyle{empty}

% globally disable paragraph indentation
\setlength{\parindent}{0pt}

\newcommand*{\sectionline}[1]{#1~\xrfill[.5ex]{1pt}[pseccolor]}

\newcommand*{\cvsection}[1]{\section*{#1}}
\titleformat{\section}
	{\color{sectioncolor}\normalfont\bfseries\LARGE}{}{0pt}{}
\titlespacing*{\section}{0pt}{1.5ex}{1ex}

\newcommand*{\cvsubsection}[1]{\subsection*{#1}}
\titleformat{\subsection}
	{\color{subsectioncolor}\normalfont\large}{}{0pt}{}

\newcommand*{\profilesection}[1]{\subsubsection*{#1}}
\titleformat{\subsubsection}
	{\color{pseccolor}\normalfont\huge}{}{0pt}{\color{pseccolor}\sectionline}
\titlespacing*{\subsubsection}{0pt}{1ex}{1ex}

%-------------------------------------------------------------------------------
%                              SIDEBAR ELEMENTS
%-------------------------------------------------------------------------------
\newcommand*{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand*{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand{\plotprofilepicture}{}
\newcommand*{\cvprofilepic}[1]{
	\renewcommand{\cvprofilepic}{#1}

	\ifthenelse{\equal{\profilepicstyle}{profilecircle}}{
		\renewcommand{\plotprofilepicture}{\profilecircle}
	}{
		\renewcommand{\plotprofilepicture}{\profileroundedcorners}
	}
}

\newcommand*{\personal}[2]{
	\circleicon{#1} & {#2}\\
}
\newcommand{\personaldata}{}
\newcommand*{\cvcustomdata}[2]{
	\apptocmd{\personaldata}{\personal{#1}{#2}}{}{}
}
\newcommand*{\cvbirthday}[1]{\cvcustomdata{\faBirthdayCake}{#1}}
\newcommand*{\cvaddress}[1]{\cvcustomdata{\faEnvelope}{#1}}
\newcommand*{\cvphone}[1]{\cvcustomdata{\faPhone}{#1}}
\newcommand*{\cvmail}[1]{\cvcustomdata{\faAt}{\href{mailto:#1}{#1}}}
\newcommand{\nameandjob}{
	\begin{center}
		{\Huge\color{maincolor}\cvname}\par
		\setlength{\parskip}{2ex}
		{\Large\color{black!80}\cvjobtitle}\par
		\setlength{\parskip}{1ex}
	\end{center}
}
\newcommand{\profileroundedcorners}{
	\begin{figure}\centering
		\begin{tikzpicture}[x=\profilepicsize, y=\profilepicsize]
			\begin{scope}
				\path[clip]
					(0, 0) [sharp corners] --
					(0, 1) [rounded corners=\profilepicrounding] --
					(1, 1) [sharp corners] --
					(1, 0) [rounded corners=\profilepicrounding] -- cycle;
				\node[anchor=center, inner sep=0pt, xshift=\profilepicxshift,
						yshift=\profilepicyshift] (profilepic) at (0.5, 0.5)
					{\includegraphics[width=\profilepiczoom\profilepicsize]
						{\cvprofilepic}};
			\end{scope}
			\ifdim \profilepicborderwidth > 0pt
				\begin{scope}
					\draw[line width=\profilepicborderwidth, color=iconcolor]
					(0, 0) [sharp corners] --
					(0, 1) [rounded corners=\profilepicrounding] --
					(1, 1) [sharp corners] --
					(1, 0) [rounded corners=\profilepicrounding] -- cycle;
				\end{scope}
			\fi
		\end{tikzpicture}
	\end{figure}
}
\newcommand{\profilecircle}{
	\begin{figure}\centering
		\begin{tikzpicture}[x=\profilepicsize, y=\profilepicsize]
			\begin{scope}
				\clip (0, 0) circle (0.5);
				\node[anchor=center, inner sep=0pt, outer sep=0pt,
						xshift=\profilepicxshift, yshift=\profilepicyshift]
					(profilepic) at (0,0) {
				\includegraphics[width=\profilepiczoom\profilepicsize]
					{\cvprofilepic}};
			\end{scope}
			\ifdim \profilepicborderwidth > 0pt
				\begin{scope}
					\draw[line width=\profilepicborderwidth, color=iconcolor]
						(0, 0) circle (0.5\profilepicsize);
				\end{scope}
			\fi
		\end{tikzpicture}
	\end{figure}
}

\newenvironment{icontable}[3][1]
{
	\renewcommand{\arraystretch}{#1}% increase linespacing in tables; default=1
	\iftoggle{tshowframes}{
		\tabularx{\sidebartextwidth}{|m{#2} | @{\hskip #3} | X|} \hline
	}{
		\tabularx{\sidebartextwidth}{m{#2} @{\hskip #3} X}
	}
}{
	\endtabularx
}

\newcommand*\circleicon[1]{
	\tikz[baseline = (char.base)]{
		\node[
			shape=circle,
			draw,
			inner sep=1pt,
			fill=iconcolor,
			maincolor,
			text=white,
			minimum size=\hsize
		] (char) {#1};
	}
}

\newcommand{\aboutme}[1]{\parbox[b]{\linewidth}{#1}}
\newcommand{\cvicon}[1]{\makebox[1em]{\color{iconcolor} #1}}
\newcommand{\flag}[1]{\includegraphics[align=c, width=1em]{#1}}

\NewDocumentCommand{\pointskill}{ O{0em} m m m O{5} }{
	\hspace{#1} \cvicon{#2} ~ #3 \hfill
	\foreach \x in {1,...,#5}{
		\space
		{\ifnumgreater{\x}{#4}{\color{skillbg}}{\color{iconcolor}}
		\raisebox{0.5\height-0.4ex}{\scriptsize\faCircle}
		}
	}\par
}

\newcommand{\barskill}[3]{
	\begin{tikzpicture}[x=\sidebartextwidth-1pt, y=2ex]
			\draw[fill, skillbg, rounded corners=0.5em]
				(0, 0) rectangle (1, 1);
			\draw[fill, iconcolor!70, rounded corners=0.5em]
				(0, 0) rectangle (#3/100, 1);
			\node[above right] at (0, 1) {\cvicon{#1} ~ #2};
	\end{tikzpicture}
	\par
}
\newcommand{\skill}[3][0em]{
	\hspace{#1} \cvicon{#2} ~ \parbox{\linewidth-#1-2.5em}{#3} \hfill \par
}

\newenvironment{sidebarminipage}%
	{\begin{minipage}{\sidebartextwidth}}%
	{\end{minipage}}%


%-------------------------------------------------------------------------------
%                               SIDEBAR LAYOUT
%-------------------------------------------------------------------------------
\newcommand{\drawSidebarBG}{
	\AddToShipoutPictureBG*{%
		\begin{tikzpicture}[remember picture, overlay]
			\node[
				rectangle,
				fill=sidecolor,
				anchor=north west,
				minimum width=\sidebarwidth,
				minimum height=\paperheight,
			]{};
			% plot vertical red guideline
			\plotvline
		\end{tikzpicture}
	}
}

\newenvironment{sidebar}{
	\drawSidebarBG
	\begin{textblock*}{\sidebartextwidth}(\leftrightmargin, \topbottommargin)
}{
	\end{textblock*}
}

\newcommand{\frontsidebar}{}
\newcommand{\backsidebar}{}
\newcommand{\addtofrontsidebar}[1]{\apptocmd{\frontsidebar}{#1}{}{}}
\newcommand{\addtobacksidebar}[1]{\apptocmd{\backsidebar}{#1}{}{}}
\newcommand{\makefrontsidebar}{
	\begin{sidebar}
		% most sidebar commands end with \par; increase space between them
		\setlength{\parskip}{1ex}

		% insert profile picture
		\plotprofilepicture
		\vspace{1ex}

		% name and job
		\nameandjob

		% personal information
		\vspace*{0.5em}
		\begin{icontable}[1.6]{1.7em}{0.4em}
			\personaldata
		\end{icontable}

		% user definitions
		\frontsidebar
	\end{sidebar}
}
\newcommand{\makebacksidebar}{
	\begin{sidebar}
		% begin with name instead of picture
		\nameandjob

		% make sure there is no space at top, but after cvjob
		\setlength{\parskip}{1ex}

		% user definitions
		\backsidebar
	\end{sidebar}
}

%-------------------------------------------------------------------------------
%                              LIST ENVIRONMENTS
%-------------------------------------------------------------------------------
\setlength{\tabcolsep}{0pt}

\newenvironment{cvtable}[1][1]{
	\renewcommand{\arraystretch}{#1}
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}}

%\newcommand{\cvitemshort}[2]{
%	\parbox[t]{0.17\textwidth}{\raggedright #1}
%	& \parbox[t]{0.81\textwidth}{#2} \\}
\newcommand{\cvitem}[4]{
	\parbox[t]{0.17\textwidth}{\raggedright #1} &
	\parbox[t]{0.81\textwidth}{
		\if\relax\detokenize{#4}\relax
			\parbox[t]{\linewidth-\widthof{#3}-1em}{\raggedright #2}
			\hfill {\color{sectioncolor}\textbf{#3}}
		\else
			\parbox{\linewidth-\widthof{#3}-1em}{\raggedright \textbf{#2}}
			\hfill {\color{sectioncolor}\textbf{#3}} \\
			\textcolor{itemtextcolor}{#4}
		\fi
	}\\
}
\newcommand{\cvpubitem}[4]{
	\parbox[t]{0.17\textwidth}{\raggedright #4} &
	\parbox[t]{0.81\textwidth}{
		\textbf{#1} \par \textit{#2} \par #3 \vspace{\parsep}
	}\\
}
