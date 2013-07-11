%%
%% This is file `report.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% report.dtx  (with options: `class')
%% 
%% This file is derived from the following source:
%% $Id: report.dtx 2734 2012-07-27 16:08:31Z s.gonzalez $
%% 
%% Copyright (c) 2010 by Sebastián González Montesinos
%% 
%% This work may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3 of this license
%% or (at your option) any later version. The latest version of this
%% license is in http://www.latex-project.org/lppl.txt and version 1.3 or
%% later is part of all distributions of LaTeX version 2005/12/01 or
%% later.
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{ingi/report}
   [2010/07/08 v1.0 INGI annual report class.]
\DeclareOption{draft}{\PassOptionsToPackage{draft}{ifdraft}}
\DeclareOption{final}{\PassOptionsToPackage{final}{ifdraft}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ExecuteOptions{}
\ProcessOptions\relax
\LoadClass[10pt]{scrartcl}
\RequirePackage{ifxetex}
\ifxetex
\RequirePackage{xltxtra}
\else
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\fi
\RequirePackage{ifdraft}
\RequirePackage{xltxtra}
\RequirePackage{babel}
\RequirePackage{hyperref}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{natbib,bibentry}
\RequirePackage{geometry}
\RequirePackage{isodate}
\RequirePackage{paralist,enumitem}
\RequirePackage{tabularx}
\RequirePackage{suffix}
\RequirePackage{tikz}
\RequirePackage{bbding}
\pagestyle{empty}

\setitemize{itemsep=0pt}
\setitemize[3]{label=$\cdot$}

\cleanlookdateon

\definecolor{link}{named}{NavyBlue}
\hypersetup
  {pdfborder={0 0 0},
   colorlinks,
   linkcolor=link,
   anchorcolor=link
   citecolor=link,
   filecolor=link,
   menucolor=link,
   runcolor=link,
   urlcolor=link}

\geometry
  {reversemp, marginparwidth=6.15em, marginparsep=0pt,
   hmargin={3cm, 3cm}, vmargin=2.5cm, ignoreheadfoot}

\bibliographystyle{plainnat}
\newcounter{lastyear}
\setcounter{lastyear}{\year} % from isodate
\addtocounter{lastyear}{-1}
\title{Activity Report \number\value{lastyear}--\number\year}
\renewcommand{\maketitle}
  {\hrule
   \vspace{1ex}
   \begin{tabular}{m{1.16cm}l}
     \logoINGI[1.3] &
     \begin{minipage}{.6\textwidth}
       \Large\textsf{\@title}\\[2pt]
       \large \@author\\
       \normalsize\today
    \end{minipage}
    \hspace{2em}\mbox{}
  \end{tabular}
  \vspace{1ex}
  \hrule}
\DeclareUrlCommand\formatdoi{\urlstyle{rm}}
\providecommand{\doi}[1]{DOI \href{http://dx.doi.org/#1}{\formatdoi{#1}}}
\newcommand{\logoINGI}[1][1]
 {\begin{tikzpicture}[scale=.147*#1]
    \filldraw (2.85,1.8) rectangle (7.3,6.35);
    % Penrose triangle
    \begin{scope}[rotate=-15, line width=.28pt, line join=round,
      fill=white, draw=black]
      \filldraw
        (3.1232408,2.5429303) -- (4.9787767,5.8455178) --
        (2.9161277,5.8466663) -- (2.5204899,6.5538029) --
        (6.1726698,6.5543727) -- (3.9446457,2.540866) --
        (3.1232408,2.5429303) -- cycle;
      \filldraw
        (3.1231392,2.5426591) -- (.91923882,6.5537223) --
        (1.3232998,7.2810322) -- (3.1516759,3.9677318) --
        (4.17193,5.8466155) -- (4.980052,5.8466155) --
        (3.1231392,2.5426591) -- cycle;
      \filldraw
        (3.1520979,3.9683568) -- (3.5550104,4.7105493) --
        (2.5187272,6.5543409) -- (6.1728788,6.5562366) --
        (5.7881741,7.3012352) -- (1.323464,7.2807665) --
        (3.1520979,3.9683568) -- cycle;
    \end{scope}
    \node at (5.1,0.4)
      {\fontspec[Scale=#1, LetterSpace=-6pt]%
        {Frutiger LT Std 75 Black}INGI};
  \end{tikzpicture}}
\WithSuffix\newcommand\url*[1]{\href{http://#1}{#1}}
\newcommand{\marginsection}[1]%
  {\marginpar{\vspace{1ex}\hfill\fbox{\textsf{#1}}}}
\newcommand{\workLoad}[1]%
  {\pgfmathparse{int(round(#1*100))}\pgfmathresult\% load}
\newcommand{\regularWorkLoad}[2]%
  {$\pgfmathparse{int(round(#1))}\pgfmathresult/38
   \times \pgfmathparse{int(round(#2))}\pgfmathresult/47\,=\;$
   \workLoad{#1/38*#2/47}}
   % \footnote{That is #2 of 38 working hours per week,
   %   during #3 of the 47 working weeks per year. #1}
\newcommand{\highlight}{\raisebox{-.25ex}{\small\FiveStar}}

\endinput
%%
%% End of file `report.cls'.
