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

\ProvidesPackage{eclectex/university/course/practical-session}
  [2013/01/22 v0.0 EPL practical session.]

\DeclareOption*
  {\PassOptionsToClass{\CurrentOption}
     {eclectex/university/course/exercises}}

\ProcessOptions\relax

\LoadClass{eclectex/university/course/exercises}

%---[ Configuration ]---

\ohead
  {\ifdef{\@session}{Session \@session: }{}%
   \ifdef{\@title}{\@title}{}}

%% Default metadata

\if@english

\subject{Practical session}

\else

\if@french

\subject{Travail pratique}

\else

\PackageError{\filebase}{Unknown document language}{The recognised
  language options are `english`, `british` and `french`.}

\fi

\fi

%---[ Commands ]---

%%% Document data

\newcounter{session}

\if@english
\newcommand{\session}[1]
  {\def\@session{#1}
   \ifdefvoid{\@session}{}
     {\setcounter{session}{\@session}
      \subject{\engordnumber{\@session} practical session}}}
\fi


\if@french
\newcommand{\session}[1]
  {\def\@session{#1}
   \ifdefvoid{\@session}{}
     {\setcounter{session}{\@session}
      \subject{Travail pratique \@session}}}
\fi
