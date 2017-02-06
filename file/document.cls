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

\ProvidesClass{eclectex/file/document}
  [2013/07/11 v0.0 File document.]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}

\ProcessOptions\relax

\LoadClass{scrartcl}

% ---[ Packages ]---

\RequirePackage{eclectex/boilerplate}
\RequirePackage{eclectex/file/document}

