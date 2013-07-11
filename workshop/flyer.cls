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

\ProvidesPackage{eclectex/workshop/flyer}
  [2013/07/11 v0.0 Workshop flyer.]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{eclectex/document/flyer}}

\ProcessOptions\relax

\LoadClass{eclectex/document/flyer}

%---[ Packages ]---

\RequirePackage{eclectex/document/data}
\RequirePackage{eclectex/workshop/data}
\RequirePackage{eclectex/conference/data}
\RequirePackage{xstring}
\RequirePackage{pgffor}
\RequirePackage{tikz}
\usetikzlibrary{positioning}

%---[ Look & feel ]---

\let\orig@section=\section
\renewcommand{\section}
  {\vspace{-\parskip}\orig@section}

%---[ Commands & environments ]---

\renewcommand{\maketitle}
 {\newpage
  \begin{center}
  \ifdefvoid{\workshop@acronym}%
    {}{{\workshop@acronymFont%
        \workshop@acronym'\StrRight{\getdateyear{workshop@date}}{2}\par}}%
  \ifdefvoid{\workshop@title}%
    {}{{\vspace{1em}
        \workshop@titleFont\workshop@title
        \par}}%
  \ifdefstring{\workshop@year\workshop@month\workshop@day}{}%
    {}{{\vspace{1em}
        \workshop@dateFont\displaydate{workshop@date}%
        \ifdefvoid{\conference@location}{\par}{, }}}%
  \ifdefvoid{\conference@location}%
    {}{{\conference@locationFont\conference@location
        \par}}%
  \ifdefvoid{\conference@acronym}%
    {}{\vspace{1ex}
      \begin{tikzpicture}
        \node (conference)
          {\conference@acronymFont{}Co-located with \conference@acronym};
        \node[right=0pt of conference]
          {\ifdefvoid{\conference@logo}{}%
             {\includegraphics{\conference@logo}}};
      \end{tikzpicture}}
  \ifdefvoid{\workshop@website}
    {}{\par\vspace{1em}
       \href{\workshop@websiteURL}{\workshop@website}\par}
  \end{center}}

\newcommand{\workshopMember}[3]
  {\ifblank{#1}{}
     {#1\ifblank{#2}{\par}%
        {\\#2\ifblank{#3}{\par}%
           {\\#3\par}}}}

%---[ Defaults ]---

\AtBeginDocument
  {\ifdefvoid{\@title}%
     {\ifdefvoid{\workshop@title}{}{\title{\workshop@title}}}{}%
   \ifdefvoid{\@subject}%
     {\subject{Workshop flyer}}{}%
   \ifdefvoid{\@author}%
     {\ifdefvoid{\workshop@organizers}{}{\author{\workshop@organizers}}}{}}

\pgfkeys{/generic/workshop/.cd,
  titleFont={\Huge\sffamily},
  acronymFont={\huge\sffamily},
  dateFont={\Large\sffamily}}

\pgfkeys{/generic/conference/.cd,
  acronymFont={\large\sffamily},
  locationFont={\Large\sffamily}}
