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

\ProvidesPackage{eclectex/university/course/exercises}
  [2013/01/22 v0.0 EPL exercises.]

\newif\if@answers
\DeclareOption{answers}{\@answerstrue}

\newif\if@instructions
\DeclareOption{instructions}{\@instructionstrue}

\DeclareOption*
  {\PassOptionsToClass
     {\CurrentOption}{eclectex/university/course/notes}}

\ProcessOptions\relax

\LoadClass{eclectex/university/course/notes}

%---[ Packages ]---

\RequirePackage{eclectex/fonts}

\RequirePackage{engord}
\RequirePackage{verbatim}
\usetikzlibrary{positioning}
\usetikzlibrary{decorations.pathmorphing}

%---[ Configuration ]---

%% Font.

\ifxetex
\newfontfamily\stampfont[Scale=1]{Hecubus}
\else
\newcommand{\stampfont}{\sffamily}
\fi
\newcommand{\answerfont}{\sffamily}
\newcommand{\instructionfont}{\sffamily}

%% Color.

\definecolor{answercolor}{cmyk}{.01, .84, .99, .04}
\definecolor{instructioncolor}{cmyk}{.76, .0, .0, .0}

\ohead
  {\ifdef{\@title}{\@title}{}}

\tikzstyle{answer}=[font=\color{answercolor}]
\tikzstyle{instruction}=[font=\color{instructioncolor}]

%% Stamps

\tikzstyle{stamp}=
  [anchor=north east,
   draw=gray, fill=white, rounded corners,
   decorate, decoration={random steps, segment length=15pt, amplitude=2pt},
   inner sep=.5em, line width=2pt, rotate=-15]

\newlength{\next@stamp}
\setlength{\next@stamp}{0em}
\newlength{\stamp@width}
\newlength{\stamp@prefix@width}

\newcommand{\stamp}[3][]
  {\settowidth{\stamp@width}{\stampfont\huge#2}%
   \settowidth{\stamp@prefix@width}{\stampfont\small#1}%
   \tikz[remember picture, overlay]
     \node[stamp, text width=\stamp@width+.3\stamp@prefix@width, #3]
       at (\textwidth,7em+\next@stamp)
       {\stampfont\ifblank{#1}{}{{\small#1}\\\hfill}\huge{#2}};%
   \addtolength{\next@stamp}{-4em}}

% from hyperref's documentation:
\expandafter\def\expandafter\pdfstringdefPreHook
\expandafter
  {\pdfstringdefPreHook
   \renewcommand*{\engordletters}[1]{##1}
   \if@instructions
     \edef\@subject{{\@subject} (for instructors)}
   \else\if@answers
     \edef\@subject{{\@subject} (with answers)}
   \fi\fi}

%---[ Commands ]---

%% LaTeX.

\let\orig@maketitle\maketitle
\renewcommand{\maketitle}
  {\orig@maketitle
   \if@answers
     \stamp[with]{ANSWERS}{answer}
   \else
     % simulate space left by tikz (don't understand why it does)
     \tikz[remember picture, overlay] \node {};
   \fi
   \if@instructions
     \stamp[for]{INSTRUCTORS}{instruction}
   \else
     % simulate space left by tikz (don't understand why it does)
     \tikz[remember picture, overlay] \node {};
   \fi
   % compensate for space left by tikz (hand-coded)
   \vspace{-\baselinestretch\baselineskip}}

%%% General

\newenvironment{remark}{\small\raisebox{-.5ex}{\PencilRight}\footnotesize}{}

%%% Answers

\newcommand{\answerformat}{\answerfont\color{answercolor}}

\if@answers
  \newenvironment{answers}{\answerformat}{}
\else
  \let\answers=\comment
  \let\endanswers=\endcomment
\fi

\newcommand{\answer}[1]
  {\if@answers\begingroup\leavevmode\answerformat#1\endgroup\fi}

%%% Instructions

\newcommand{\instructionformat}{\instructionfont\color{instructioncolor}}

\if@instructions
  \newenvironment{instructions}
    {\instructionformat
     \setlength{\parskip}{1ex}
     \setlength{\parindent}{0pt}}
    {}
\else
  \let\instructions=\comment
  \let\endinstructions=\endcomment
\fi

\newcommand{\instruction}[1]
  {\if@instructions\begingroup\leavevmode\instructionformat#1\endgroup\fi}

%---[ Defaults ]---

\subject{Exercises}
