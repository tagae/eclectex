% This file is part of eclecTeX, a multi-purpose LaTeX library.
%
% © 2009-2013 Sebastián González Montesinos.
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License version 1.3 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The Current Maintainer of this work is Sebastián González.

% Dev Notes
% ---------
% Add labels for each event timespan, so that it becomes possible to
% refer to them (the ref generates for instance "1998--2000" or if the
% label is in a section different from the current one, "1998--2000 of
% section XYZ"). If integrated with cleveref, it could prefix "years"
% to the \cref reference.

\NeedsTeXFormat{LaTeX2e}[1999/12/01]

\ProvidesClass{eclectex/people/cv}
  [2013/07/11 0.0 Curriculum Vitæ.]

% ---[ Options ]---

\RequirePackage{etoolbox}

\def\cv@base@class{scrreprt}
\PassOptionsToClass{DIV=15, parskip=half, notitlepage}{scrreprt}

\def\cv@minimal{-2}
\def\cv@compact{-1}
\def\cv@normal{0}
\def\cv@detailed{1}
\def\cv@exhaustive{2}

\edef\cv@max@level{\cv@exhaustive}

\DeclareOption{minimal}
  {\set@cv@length{minimal}
   %\PassOptionsToPackage{small}{titlesec}
   \AtBeginDocument{\cv@compress@space}}

\DeclareOption{compact}
  {\set@cv@length{compact}
   %\PassOptionsToPackage{medium}{titlesec}
   \AtEndPreamble{\cv@compress@space}}

\DeclareOption{normal}
  {\set@cv@length{normal}}

\DeclareOption{detailed}
  {\set@cv@length{detailed}}

\DeclareOption{exhaustive}
  {\set@cv@length{exhaustive}}

\DeclareOption{twocolumn}
  {\AtBeginDocument{\cv@twocolumn}
   %\PassOptionsToPackage{center}{titlesec}
   \PassOptionsToClass{\CurrentOption}{\cv@base@class}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\cv@base@class}}

\newcommand{\set@cv@length}[1]
  {\def\cv@length@option{#1}
   \edef\cv@length{\csname cv@#1\endcsname}}

\ExecuteOptions{normal}

\ProcessOptions\relax

\LoadClass{\cv@base@class}

% ---[ Packages ]---

\RequirePackage{eclectex/tweaks}
\RequirePackage{eclectex/hypertext}
\RequirePackage{eclectex/fonts}
\RequirePackage{eclectex/i18n}
\RequirePackage{eclectex/time}
\RequirePackage{eclectex/lists}
\RequirePackage{eclectex/graphics}
\RequirePackage{eclectex/document/data}
\RequirePackage{eclectex/people/data}
\RequirePackage{eclectex/file/document}

\RequirePackage{geometry} % must be loaded and configured early on
\RequirePackage{environ}
\RequirePackage{tikz}
\RequirePackage{marvosym}
\RequirePackage[alpine]{ifsym}
\RequirePackage{dingbat}
\RequirePackage{tocbasic}
\RequirePackage{enumitem}
\RequirePackage{verbatim}
\RequirePackage{xspace}
\RequirePackage[compact]{titlesec}

% ---[ Configuration ]---

%% Package 'tikz'.

\usetikzlibrary{positioning}
\usetikzlibrary{calc}

%% Package 'eclectex/file/document'

\renewcommand{\documentTitleFont}{}
\renewcommand{\documentTitleHeadingFont}{\large\sffamily}
\renewcommand{\documentAuthorFont}{\large}
\renewcommand{\documentDateFont}{\normalsize}
\renewcommand{\documentRecipientFont}{\small\centering}

%% Fonts.

\newcommand{\cvChapterFont}{}
\newcommand{\cvNameFont}{\usekomafont{title}\Large}

% Table of contents.
\setcounter{tocdepth}{0}
\setuptoc{toc}{leveldown} % treat as section, not chapter

% Chapters.
\ifnumgreater{\cv@length}{\cv@normal}
  {%\renewcommand*{\chapterpagestyle}{scrheadings}
   %\renewcommand*{\chapterheadstartvskip}{}
   %\renewcommand*{\chapterheadendvskip}{\vspace*{.8\baselineskip}}
   %\addtokomafont{chapter}{\centering}
   \renewcommand{\chapter}[2][]%
     {\clearpage%
      \hrulefill{\cvChapterFont\quad#2\quad}\hrulefill%
      \addtocounter{chapter}{1}%
      \addcontentsline{toc}{chapter}{#2}}
   \renewcommand{\chapter}[2][]% Works with KOMA-Script
     {\begin{center}
        \vspace{1em}
        \Large\cvChapterFont#2
        \vspace{-1ex}
      \end{center}
      \refstepcounter{chapter}%
      \addchaptertocentry{\thechapter}{#2}}}
  % else
  {\renewcommand{\chapter}[2][]{}}

% Sections.
\setcounter{secnumdepth}{-1}
%\renewcommand*{\othersectionlevelsformat}[1]{}

% ---[ Commands ]---

% Center document title.
\preto\maketitle
  {% Remove author from eclectex/file/document title.
   \let\cv@author=\@author%
   \undef{\@author}%
   % Centre eclectex/file/document title.
   \begin{center}}
\appto\maketitle
 {\end{center}%
  % Restore document author.
  \xdef\@author{\cv@author}}

% Complement document title.
\appto\maketitle
  {\smallskip
   \begin{center}
     \begin{tikzpicture}
       \node (photo)
         [basicbox]
         {\ifdefvoid{\@personPhoto}{}
            {\includegraphics[height=6em]{\@personPhoto}}};
       \node (identification)
         [basicbox, text width=.4\textwidth, right=1ex of photo]
         {\ifdefvoid{\@personCommonName}{}
            {{\cvNameFont\@personCommonName}\par}
          \ifdefvoid{\@personPosition}{}
            {\@personPosition\par}
          \ifdefvoid{\@personAffiliation}{}
            {\listEnumeration[oneperline]{\@personAffiliation}\par}};
       \node (address)
         [contact, right=\cv@address@sep of identification.north east,
          anchor=north west,
          text width=.4\textwidth]
         {\ifdefvoid{\@personAddress}{}
            {\ifthenelse{\equal{\@personAddressLink}{}}
               {\@personAddress}
               {\href{\@personAddressLink}{\@personAddress}}}};
       \node (phone)
         [contact, below=0ex of address.south west, anchor=north west]
         {\ifdefvoid{\@personPhone}{}{\@personPhone}};
       \node (e-mail)
         [contact, below=0ex of phone.south west, anchor=north west]
         {\ifdefvoid{\@personEmail}{}
            {\edef\email@args{{\expandonce\@personEmail}}%
             \expandafter\email\email@args}};
       \node (web)
         [contact, below=0ex of e-mail.south west, anchor=north west]
         {\ifdefvoid{\@personWeb}{}
            {\edef\webpage@args{{\expandonce\@personWeb}}%
             \expandafter\webpage\webpage@args}};
       \node (address icon)
         [contacticon, inner ysep=.3ex,
          right=0ex of address.north west, anchor=north east]
         {\ifdefvoid{\@personAddress}{}{\raisebox{2pt}{\large\Letter}}};
       \node (phone icon)
         [contacticon, left=0ex of phone]
         {\ifdefvoid{\@personPhone}{}{\raisebox{1pt}{\large\Telefon}}};
       \node (e-mail icon)
         [contacticon, left=0ex of e-mail]
         {\ifdefvoid{\@personEmail}{}{\small\MVAt}};
       \node (web icon)
         [contacticon, left=0ex of web]
         {\ifdefvoid{\@personWeb}{}{\footnotesize\textbf{W}}};
     \end{tikzpicture}
     \ifnumless{\cv@length}{\cv@normal}{}
       {\par
        \vspace{\cv@main@data@bottom@sep}
        \cv@print@civil@data}%
   \end{center}
   \titleSkip}

%% Document data.

\title{Curriculum Vitæ}
\plaintitle{Curriculum Vitae}

\subject{Course of life}

%% Personal data.

\AtBeginDocument
  {\ifdefvoid{\@author} % If no explicit author...
     {\author{\@personCommonName}}{}} % ... assume it is CV owner.

%% Detail level.

\newcounter{cv@current@level}
\setcounter{cv@current@level}{\cv@normal}

\def\cv@detail@level@stack{}

\newcommand{\cv@push@level}[1]
  {\listConcat
     {\arabic{cv@current@level}}{\cv@detail@level@stack}
     {\cv@detail@level@stack}%
   \setcounter{cv@current@level}{#1}%
   \ifnumgreater{\value{cv@current@level}}{\cv@max@level}
     {\ClassError{eclectex/person/cv}
        {Too much detail}
        {The given information will not appear at any level of detail}}{}}

\newcommand{\cv@pop@level}
  {\listHeadTail{\cv@detail@level@stack}
     {\cv@top@stack@level}{\cv@detail@level@stack}%
   \setcounter{cv@current@level}{\cv@top@stack@level}}

\pgfkeys{/eclectex/person/cv/.cd,
  level/.is choice,
  level/minimal/.code={\def\cv@declared@level{\cv@minimal}},
  level/compact/.code={\def\cv@declared@level{\cv@compact}},
  level/normal/.code={\def\cv@declared@level{\cv@normal}},
  level/detailed/.code={\def\cv@declared@level{\cv@detailed}},
  level/exhaustive/.code={\def\cv@declared@level{\cv@exhaustive}}}

\NewEnviron{level}[1][]
  {\edef\cv@declared@level{\value{cv@current@level}+1}%
   \pgfkeys{/eclectex/person/cv/.cd, #1}%
   \cv@push@level{\cv@declared@level}%
   \ifnumgreater{\value{cv@current@level}}{\cv@length}{}{\BODY\xspace}%
   \cv@pop@level}

%% Events.

\NewEnviron{event}[2][]%
  {\pgfkeys{/eclectex/person/cv/.cd, level=minimal, #1}%
   \cv@push@level{\cv@declared@level}%
   \ifnumgreater{\value{cv@current@level}}{\cv@length}{}
     {\noindent%
      \begin{tikzpicture}[event]
       \node (time span)
         [eventtimespan]
         {\timeSpan{#2}};
       \node (event)
         [eventdesc,
          right=\eventTimeSpanSep of time span.north east, anchor=north west]
         {\BODY};
     \end{tikzpicture}%
     \ifdimgreater{\parskip}{0pt}{}{\smallskip}}%
   \cv@pop@level}

\newcommand{\noteworthy}
  {\par\tikz[remember picture]
     \coordinate (noteworthy) at (0,0);%
   \tikz[remember picture, overlay]
     \node
       [eventtimespan, anchor=south west]
       at (noteworthy.south -| time span.west)
       {\ding{80}};} % from pifont

%% Descriptions.

\newenvironment{complement}
  {\level}
  {\endlevel}

\newenvironment{info}[1][]
  {\level[#1]\cv@info@start}
  {\cv@info@end\endlevel}

\newcommand{\cv@info@start}{\par}
\newcommand{\cv@info@end}{\par}

\newenvironment{notes}[1][level=normal]
  {\level[#1]%
   \par
   \vspace{-1ex}
   \vspace{\notes@bar@top@skip}
   \tikz \draw (0,0) -- (2,0);
   \par
   \vspace{\notes@bar@bottom@skip}
   \footnotesize}
  {\par\endlevel}

\newcommand{\atlevel}[2]
  {\ifnumgreater{\csuse{cv@#1}}{\cv@length}{}{#2}}

%% Academic grades.

\pgfkeys{/eclectex/lists/academic/grade/.style=
  {firstsep={,\\}, innersep={,\\}, lastsep={{, }}, endmark={.}}}

\ifnumless{\cv@length}{\cv@normal}
  {\pgfkeys{/eclectex/lists/academic/grade/.append style=
     {innersep={{, }}}}}{}

\pgfkeys{/eclectex/academic/grade/.cd,
  date/.store in=\academic@grade@date, date/.value required}

\newcommand{\academicGrade}[3][]
  {\declareAcademicGrade[#1]{#2}{#3}%
   \printAcademicGrade}

\newcommand{\declareAcademicGrade}[3][]
  {\pgfkeys{/eclectex/academic/grade/.cd,
      date={}, #1}%
   \def\academic@grade@title{#2}%
   \listLast{#3}{max(\cv@length+3,2)}{\academic@grade@institution}}

\newcommand{\printAcademicGrade}
  {\textbf{\academic@grade@title}\\
   \listEnumeration[academic/grade]{\academic@grade@institution}}

%% Scholarship.

\pgfkeys{/eclectex/lists/academic/scholarship/.style=
  {plain}}

\newcommand{\scholarship}[1]
  {\listEnumeration[academic/scholarship]{#1}}

%% Courses.

\newif\ifcv@course@inprogress

\pgfkeys{/eclectex/person/cv/course/.cd,
  address/.store in=\cv@course@address, address/.value required,
  by/.store in=\cv@course@teacher, by/.value required,
  duration/.store in=\cv@course@duration, duration/.value required,
  time span/.store in=\cv@course@time@span, time span/.value required,
  in progress/.is if=cv@course@inprogress}

% TODO: 'in progress' can be derived from '\today' and 'time span' if
% unspecified.
% TODO: 'duration' can be derived from 'time span' if unspecified.
\newcommand{\course}[3][]
  {\pgfkeys{/eclectex/person/cv/course/.cd,
     % reset data
     address={}, by={}, duration={}, time span={}, in progress=false,
     #1}% set given data
   \def\cv@course@title{#2}%
   \def\cv@course@institution{#3}%
   \textbf{\cv@course@title}
   \ifdefvoid{\cv@course@duration}{}{ (\cv@course@duration)}%
   \ifcv@twocolumn. \else\par\fi%
   \ifdefvoid{\cv@course@teacher}{}{{\cv@course@teacher} from }%
   \cv@course@institution
   \ifcv@twocolumn. \else\par\fi%
   \cv@aux@reset@sentence
   \ifnumless{\cv@length}{\cv@normal}{}
    {\ifdefvoid{\cv@course@address}{}
       {Taught at \cv@course@address\cv@aux@sentencetrue}%
     \ifdefvoid{\cv@course@time@span}{}
       {\ifcv@aux@sentence{ from }\fi%
        \timeSpan{\cv@course@time@span}}}%
    \ifcv@course@inprogress\par\textsf{\MVRightarrow~In progress.}\fi}

%% Internships.

\pgfkeys{/eclectex/person/cv/internship/.cd,
  subject/.store in=\cv@internship@subject, subject/.value required,
  time span/.store in=\cv@internship@time@span, time span/.value required,
  host/.store in=\cv@internship@host, host/.value required}

\newcommand{\internship}[2][]
  {\pgfkeys{/eclectex/person/cv/internship/.cd,
      time span={}, subject={}, host={}, % reset data
      #1}% set given data
   \def\cv@course@institution{#2}%
   \cv@course@institution%
   \cv@aux@sentencefalse
   \ifdefvoid{\cv@internship@host}{}
     {. Hosted by \cv@internship@host\cv@aux@sentencetrue}%
   \ifdefvoid{\cv@internship@subject}{}
     {. Worked on \textsl{\cv@internship@subject}\cv@aux@sentencetrue}%
   \ifdefvoid{\cv@internship@time@span}{}
     {\ifcv@aux@sentence\ from \else. From\ \fi
      \timeSpan[english]{\cv@internship@time@span}.}}

%% Auxiliary

\newif\ifcv@aux@sentence

\newcommand{\cv@aux@reset@sentence}
  {\cv@aux@sentencefalse}

\newcommand{\cv@aux@finish@sentence}
  {\ifcv@aux@sentence. \fi%
   \cv@aux@reset@sentence}

%% Layout.

\geometry{top=20mm, bottom=15mm, left=20mm, right=15mm}

\setlength{\parindent}{0pt}

\newlength{\cv@address@sep}
\setlength{\cv@address@sep}{3em}

\newlength{\cv@civil@data@sep}
\setlength{\cv@civil@data@sep}{1ex}

\newlength{\eventTimeSpanWidth}
%\setlength{\eventTimeSpanWidth}{4.3em}
\AtBeginDocument
  {\settowidth{\eventTimeSpanWidth}{\footnotesize{}2000, 2000,}}

\newlength{\eventTimeSpanSep}
\setlength{\eventTimeSpanSep}{1em}

\newlength{\eventSideNotesWidth}
\AtBeginDocument
  {\setlength{\eventSideNotesWidth}{\eventTimeSpanWidth+\eventTimeSpanSep}}

\newlength{\eventDescWidth}
\AtBeginDocument
  {\setlength{\eventDescWidth}{1.02\linewidth-\eventSideNotesWidth}}

\newcommand{\titleSkip}{}

\newlength{\notes@bar@top@skip}
\setlength{\notes@bar@top@skip}{0ex}

\newlength{\notes@bar@bottom@skip}
\setlength{\notes@bar@bottom@skip}{0ex}

\newlength{\cv@main@data@top@sep}
\setlength{\cv@main@data@top@sep}{1em}

\newlength{\cv@main@data@bottom@sep}
\setlength{\cv@main@data@bottom@sep}{0ex}

\tikzstyle{basicbox}=[inner sep=0pt]

\tikzstyle{event}=
  [basicbox, remember picture]

\tikzstyle{eventtimespan}=
  [basicbox, font=\footnotesize,
   minimum height=1em,
   text width=\eventTimeSpanWidth, align=flush right]

\tikzstyle{eventdesc}=
  [basicbox, text width=\eventDescWidth]

\tikzstyle{contacticon}=
  [basicbox, text width=2.7ex, minimum height=3ex]

\tikzstyle{contact}=
  [basicbox, inner ysep=.5ex]

\newcommand{\cv@compress@space}
  {%\KOMAoptions{parskip=no}
   \setlength{\cv@main@data@top@sep}{1ex}
   \setlength{\notes@bar@top@skip}{-.5ex}
   \setlength{\notes@bar@bottom@skip}{-.5ex}
   \setlength{\eventTimeSpanSep}{1em}}

\newif\ifcv@twocolumn
\newcommand{\cv@twocolumn}
  {\cv@twocolumntrue
   \geometry{top=13mm, bottom=13mm, left=13mm, right=10mm}
   \renewcommand{\cv@info@start}{}
   \renewcommand{\cv@info@end}{}
   \let\cv@one@column@maketitle=\maketitle
   \renewcommand{\maketitle}
     {\twocolumn[% have title appear in one column
       \begin{@twocolumnfalse}
         \cv@one@column@maketitle
       \end{@twocolumnfalse}]}
   \renewcommand{\titleSkip}{\bigskip}
   \setlength{\cv@main@data@bottom@sep}{1em}
   %\addtokomafont{section}{\centering}
   %\addtokomafont{subsection}{\centering}
 }

%% Theme (printing).

\newcommand{\printBirthplace}[1]
  {\listEnumeration{#1}}

\newcommand{\cv@print@civil@data}
  {\cv@aux@sentencefalse
   \ifdefvoid{\@personCitizenship}{}
     {\listEnumeration[text]{\@personCitizenship}%
      \cv@aux@sentencetrue}%
   \edef\cv@available@birthdata
     {\@personBirthdate\@personBirthplace\@personGender}%
   \ifdefvoid{\cv@available@birthdata}{}
     {\ifcv@aux@sentence{ b}\else{B}\fi{orn}%
      \cv@aux@sentencetrue
      \ifnumgreater{\cv@length}{\cv@detailed}
        {\ifdefvoid{\@personGender}{}%
           {~\ifthenelse{\equal{\@personGender}{M}}{(\Male)}
              {\ifthenelse{\equal{\@personGender}{F}}{(\Female)}
                 {(?)%
                  \PackageWarning{cv}
                    {Unrecognised gender "\@personGender"}}}}}{}%
      \ifdefvoid{\@personBirthdate}{}
        { on \printdate{\@personBirthdate}}%
      \ifdefvoid{\@personBirthplace}{}
        { in \printBirthplace{\@personBirthplace}}}{}%
   %\ifcv@aux@sentence{.}\fi
  }
