%% Copyright (c) 2023, Tom M. Ragonneau
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{talk}[2023/05/23 Beamer document class of Tom M. Ragonneau]
\RequirePackage{etoolbox}
\RequirePackage{ifdraft}

% Load Beamer class
\newif\if@license
\@licensetrue
\DeclareOption{nolicense}{\@licensefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax
\LoadClass[10pt,xcolor=dvipsnames]{beamer}

% Encoding
\RequirePackage[T1]{fontenc}

% Set theme and templates
\usetheme{metropolis}
\metroset{
    titleformat=smallcaps,
    numbering=fraction,
    progressbar=frametitle,
    block=fill,
}
\setbeamertemplate{section in toc}[sections numbered]
\usefonttheme{professionalfonts}
\setbeamerfont{standout}{size=\normalsize}

% Fonts
\setsansfont{FiraSans}[
    Path=fonts/fira-sans/,
    Extension=.otf,
    UprightFont=*-Light,
    BoldFont=*-Regular,
    ItalicFont=*-LightItalic,
    BoldItalicFont=*-Italic,
]
\setmonofont{FiraMono}[
    Path=fonts/fira-mono/,
    Extension=.otf,
    UprightFont=*-Regular,
    BoldFont=*-Bold,
]

% Manage culturally-determined typographical rules
\RequirePackage[american]{babel}
\RequirePackage{csquotes}

% Change theme colors
\definecolor{VeniceBlue}{HTML}{2F5675}
\definecolor{DarkCaramel}{HTML}{B27A03}
\definecolor{FernGreen}{HTML}{4F7942}
\setbeamercolor{normal text}{fg=VeniceBlue!70!black,bg=black!2}
\setbeamercolor{alerted text}{fg=DarkCaramel}
\setbeamercolor{example text}{fg=FernGreen!95!black}

% Plots
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}
\pgfplotsset{compat=1.18}
\usetikzlibrary{positioning}
\usepgfplotslibrary{}
\pgfplotscreateplotcyclelist{profiles}{
    thick,mark=none,VeniceBlue,solid\\
    thick,mark=none,DarkCaramel,dashed\\
    thick,mark=none,FernGreen,dotted\\
    thick,mark=none,Mahogany,dashdotted\\
}
\pgfplotsset{
    every axis/.append style={
        label style={font=\footnotesize},
        legend cell align=left,
        legend style={
            rounded corners,
            thick,
            draw=black!15,
            font=\scriptsize,
        },
        tick label style={font=\footnotesize},
    },
}

% Patch `Overfull \vbox (... too high)' in title page
\def\titlepage{\usebeamertemplate{title page}}
\setbeamertemplate{title graphic}{
    \begin{tikzpicture}[overlay,remember picture]
        \node[below left=2em and \beamer@rightmargin of current page.north east] {\inserttitlegraphic};
    \end{tikzpicture}
}

% Subliminal refinements
\RequirePackage{microtype}

% Manage frame numbering in appendices
\RequirePackage{appendixnumberbeamer}

% Reduce margins
\setbeamersize{
    text margin left=0.75\beamer@leftmargin,
    text margin right=0.75\beamer@rightmargin,
}

% Bibliography
% N.B.: the counter `cite' is used to count the number of citations.
\RequirePackage[
    style=ext-authoryear-comp,
    articlein=false,
    sortcites=false,
    maxcitenames=3,
]{biblatex}
\setbeamertemplate{bibliography item}[triangle]
\DeclareNameAlias{author}{family-given}
\setlength{\bibitemsep}{\itemsep}
\renewcommand*{\bibfont}{\scriptsize}

% Customize blocks, alert blocks, and example blocks
\renewcommand{\metropolis@block}[1]{
    \par\vskip\medskipamount%
    \setlength{\parskip}{0pt}
    \ifdefempty{\insertblocktitle}{}{
        \ifbeamercolorempty[bg]{block title#1}{%
            \begin{beamercolorbox}[rightskip=0pt plus 4em]{block title#1}}{%
        \ifbeamercolorempty[bg]{block title}{%
            \begin{beamercolorbox}[rightskip=0pt plus 4em]{block title#1}%
        }{%
            \begin{beamercolorbox}[
                sep=\dimexpr\metropolis@blocksep-\metropolis@blockadjust\relax,
                leftskip=\metropolis@blockadjust,
                rightskip=\dimexpr\metropolis@blockadjust plus 4em\relax,
            ]{block title#1}%
        }}%
            \usebeamerfont*{block title#1}%
            \metropolis@strut%
            \insertblocktitle%
            \metropolis@strut%
        \end{beamercolorbox}%
        \nointerlineskip%
    }%
    \ifbeamercolorempty[bg]{block body#1}{%
        \begin{beamercolorbox}[vmode]{block body#1}}{
    \ifbeamercolorempty[bg]{block body}{%
        \begin{beamercolorbox}[vmode]{block body#1}%
    }{%
        \begin{beamercolorbox}[sep=\metropolis@blocksep, vmode]{block body#1}%
        \vspace{-\metropolis@parskip}
    }}%
        \usebeamerfont{block body#1}%
        \setlength{\parskip}{\metropolis@parskip}%
}

% SI units
\RequirePackage{siunitx}

% License
\RequirePackage[
    type={CC},
    modifier={by-sa},
    version={4.0},
    hyperxmp=false,
]{doclicense}
\apptocmd{\doclicenseLongName}{license}{}{}
\if@license
    \AtEndDocument{
        \begin{frame}[standout]
            This presentation is licensed under a \doclicenseLongNameRef.
            \begin{center}
                \upshape\doclicenseImage[imagewidth=0.3\textwidth]
            \end{center}

            \bigskip

            It is based on the metropolis Beamer theme, available at
            \begin{center}
                \normalfont\href{https://github.com/matze/mtheme}{\texttt{https://github.com/matze/mtheme}}.
            \end{center}
        \end{frame}
    }
\fi

% Fine-tuning spacing in formulas
% Make @ behave as per catcode 13 (active). TeXbook p. 155.
\mathcode`@="8000{\catcode`\@=\active\gdef@{\mkern1mu}}

% Mathematics
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{cases}
\RequirePackage{empheq}
\usepackage[bb=dsfontserif]{mathalpha}
% Operators
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\DeclareMathOperator{\card}{card}
\DeclareMathOperator{\conv}{conv}
\DeclareMathOperator{\diag}{diag}
\DeclareMathOperator{\Diag}{Diag}
\DeclareMathOperator{\diam}{diam}
\DeclareMathOperator{\dist}{dist}
\DeclareMathOperator{\grad}{grad}
\DeclareMathOperator{\hess}{Hess}
\DeclareMathOperator{\range}{range}
\DeclareMathOperator{\rank}{rank}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\vol}{vol}
\DeclareMathOperator{\vspan}{span}
% Sets
\newcommand*{\C}{\mathbb{C}}
\newcommand*{\F}{\mathbb{F}}
\newcommand*{\N}{\mathbb{N}}
\newcommand*{\Q}{\mathbb{Q}}
\newcommand*{\R}{\mathbb{R}}
\newcommand*{\Z}{\mathbb{Z}}
% Notations
\newcommand*{\du}{\mathrm{d}}
\newcommand*{\eu}{\mathrm{e}}
\newcommand*{\iu}{\mathrm{i}}
\newcommand*{\pinv}{\dagger}
\newcommand*{\T}{\mathsf{T}}
% Macros
\newcommand*{\abs}[2][]{#1\lvert#2#1\rvert}
\newcommand*{\ceil}[2][]{#1\lceil#2#1\rceil}
\newcommand*{\floor}[2][]{#1\lfloor#2#1\rfloor}
\newcommand*{\inner}[2][]{#1\langle#2#1\rangle}
\newcommand*{\norm}[2][]{#1\lVert#2#1\rVert}
\newcommand*{\set}[2][]{#1\{#2#1\}}

% QR codes
\ifdraft{\PassOptionsToPackage{draft}{qrcode}}{}
\RequirePackage[nolinks]{qrcode}
\qrset{level=Q,version=4}
% Make QR codes clickable (the document is compiled with XeLaTeX)
\setlength{\XeTeXLinkMargin}{1pt}
\let\old@qrcode\qrcode\relax
\def\qrcode#1{\href{#1}{\XeTeXLinkBox{\old@qrcode{#1}}}}
