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

\ProvidesPackage{eclectex/document/flyer}
  [2013/07/11 v0.0 Generic flyer.]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

\ProcessOptions\relax

\LoadClass{scrartcl}

%---[ Packages ]---

\RequirePackage{eclectex/document/boilerplate}
\RequirePackage{etoolbox}
\RequirePackage[margin={1.5cm, 1.4cm}]{geometry}

%---[ Commands ]---

\newcommand{\supertitleformat}[1]{\def\@supertitleformat{#1}}
\newcommand{\titleformat}[1]{\def\@titleformat{#1}}
\newcommand{\dateformat}[1]{\def\@dateformat{#1}}

\renewcommand{\maketitle}
 {\newpage
  \centering
  \ifdefvoid{\@supertitle}
    {}{{\@supertitleformat\@supertitle\\}}
  \ifdefvoid{\@title}
    {}{{\@titleformat\@title\\}}
  \ifdefvoid{\@date}
    {}{{\@dateformat\@date\\}}}

%---[ Defaults ]---

\supertitleformat{\Large\bf}
\titleformat{\huge\bf}
\dateformat{\large\bf}

\pagestyle{empty}
