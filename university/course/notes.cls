% This file is part of eclecTeX, a multi-purpose LaTeX library.
%
% © 2009-2013 Sebastián González Montesinos.
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License version 1.3 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The Current Maintainer of this work is Sebastián González.

\NeedsTeXFormat{LaTeX2e}[1999/12/01]

\ProvidesPackage{eclectex/university/course/notes}
  [2013/07/11 v0.0 Course notes.]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

\ProcessOptions\relax

\LoadClass[11pt,DIV=12]{scrartcl}

%---[ Packages ]---

\RequirePackage{eclectex/i18n}
\RequirePackage{eclectex/time}
\RequirePackage{eclectex/fonts}
\RequirePackage{eclectex/hypertext}
\RequirePackage{eclectex/formatting}
\RequirePackage{eclectex/copyright}
\RequirePackage{eclectex/document/data}
\RequirePackage{eclectex/document/header}
\RequirePackage{eclectex/university/data}
\RequirePackage{eclectex/university/course/data}

\RequirePackage{tikz}

%---[ Configuration ]---

%% Logo.

\newlength{\doclogosep}
\setlength{\doclogosep}{1em}

\tikzstyle{doclogo}=[]

\newcommand{\doclogo}{}

\newlength{\doclogowidth}
\setlength{\doclogowidth}{0pt}

\newlength{\docdata@width}
\setlength{\docdata@width}{\textwidth}

\AtBeginDocument
  {\ifdefvoid{\doclogo}{}
     {\settowidth{\doclogowidth}{\doclogo}
      \setlength{\docdata@width}{\textwidth}
      \addtolength{\docdata@width}{-\doclogowidth}
      \addtolength{\docdata@width}{-\doclogosep}}}

%% Header.

\ihead
  {\foreach \x [remember=\x as \lastx]
     in {course,department,faculty,university}
     {\ifcsvoid{@\x}{}%
        {\ifdefvoid{\lastx}{}{ / }\acs{\csuse{@\x}}}}}

\ohead
  {\ifdefvoid{\@title}{}{\@title}}

\setkomafont{pageheadfoot}{\normalfont\sffamily}

\tikzstyle{docdata}=
  [text width=\docdata@width, font=\sffamily]

\tikzstyle{revinfo}=
  [font=\footnotesize\sffamily, opacity=.7]

%---[ Commands ]---

%% LaTeX.

\renewcommand{\maketitle}
 {\cleardoublepage
  \thispagestyle{empty}
  \noindent
  \ifdimgreater{\doclogowidth}{0pt}
    {\begin{minipage}{\doclogowidth}
        \ifdefvoid{\doclogoURL}
          {\doclogo}
          {\href{\doclogoURL}{\doclogo}}%
     \end{minipage}%
     \hfill}{}%
  \begin{minipage}{\docdata@width}
    \sffamily
    \ifdefvoid{\@university}{}{\ac{\@university}\par}%
    \ifdefvoid{\@faculty}{}{\ac{\@faculty}\par}%
    \ifdefvoid{\@department}{}{\ac{\@department}\par}%
    \ifdefvoid{\@course}{}{{\bfseries\ac{\@course}}\par}%
    \ifdefvoid{\@subject}{}{\textbf{\@subject}}%
    \ifdefvoid{\@edition}
      {\ifdefvoid{\@subject}{}{\par}}
      {\textbf{\ifdefvoid{\@subject}{}{, }\@edition~edition}\par}%
    {\footnotesize
     \ifdefvoid{\@date}
       {\ifdef{\@datestart}{\daterange{\@datestart}{\@dateend}}{}}
       {\printdate{\@date}%
        \ifdefvoid{\@sessionStartTime}{}{, \@sessionStartTime%
          \ifdefvoid{\@sessionEndTime}{}{ till \@sessionEndTime}}}%
     \ifdefvoid{\@location}{}{ @ {\@location}}%
     \ifboolexpr
       { not test {\ifdefvoid{\@contact}} and
         not test {\ifdefvoid{\contact@email}} }
       {Contact: {\@contact} <\contact@email>}{}%
     \ifboolexpr
       { test {\ifdefvoid{\@contact}} and
         not test {\ifdefvoid{\contact@email}} }
       {Contact: \contact@email}{}%
     \ifboolexpr
       { not test {\ifdefvoid{\@contact}} and
         test {\ifdefvoid{\contact@email}} }
       {Contact: \@contact}{}}
  \end{minipage}
  \par\bigskip
  \ifdefvoid{\@title}{\bigskip}
    {\noindent
     \begin{center}
       \usekomafont{title}
       \ifdefvoid{\@supertitle}{}{\large\@supertitle\par}
       \huge\@title\par\medskip
       \ifdefvoid{\@subtitle}{}{\Large\textsl{\@subtitle}\par}
     \end{center}
     \par\medskip}
  \afterparnoindent}

%% Contributors.

\newcommand{\makecontributors}
  {\section*{Contributors}
   \par
   \@contributors
   \par}

%---[ Defaults ]---

\subject{Course notes} % from document-metadata
