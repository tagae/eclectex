% This file is part of eclecTeX, a multi-purpose LaTeX library.
%
% © 2009-2014 Sebastián González Montesinos.
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License version 1.3 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The Current Maintainer of this work is Sebastián González.

\NeedsTeXFormat{LaTeX2e}[1999/12/01]

\ProvidesPackage{eclectex/university/course/syllabus}
  [2013/01/22 v0.0 EPL syllabus.]

\DeclareOption*
  {\PassOptionsToClass
     {\CurrentOption}{eclectex/university/course/notes}}

\ProcessOptions\relax

\LoadClass{eclectex/university/course/notes}

%---[ Packages ]---


%---[ Configuration ]---

%---[ Commands ]---

%---[ Defaults ]---

\if@english
\subject{Syllabus}
\else
\if@french
\subject{Cahier de charges}
\fi
\fi
