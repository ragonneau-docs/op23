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

% Manage culturally-determined typographical rules
\RequirePackage[american]{babel}
\RequirePackage{csquotes}

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

% Change theme colors
\definecolor{VeniceBlue}{HTML}{2F5675}
\definecolor{Caramel}{HTML}{C68E17}
\definecolor{FernGreen}{HTML}{4F7942}
\setbeamercolor{normal text}{fg=VeniceBlue!70!black,bg=black!2}
\setbeamercolor{alerted text}{fg=Caramel}
\setbeamercolor{example text}{fg=FernGreen!95!black}

% Patch `Overfull \vbox (... too high)' in title page
\RequirePackage{tikz}
\usetikzlibrary{positioning}
\def\titlepage{\usebeamertemplate{title page}}
\setbeamertemplate{title graphic}{
    \begin{tikzpicture}[overlay,remember picture]
        \node[below left=2em and \beamer@rightmargin of current page.north east] {\inserttitlegraphic};
    \end{tikzpicture}
}

% Patch `Token not allowed in a PDF string (Unicode)' in appendix
\pdfstringdefDisableCommands{\def\translate#1{#1}}

% Font and encoding
\RequirePackage[T1]{fontenc}
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

% Subliminal refinements
\RequirePackage{microtype}

% Manage frame numbering in appendices
\RequirePackage{appendixnumberbeamer}

% Reduce margins
\setbeamersize{
    text margin left=0.75\beamer@leftmargin,
    text margin right=0.75\beamer@rightmargin,
}

% Plots
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}
\pgfplotsset{compat=1.18}
\usetikzlibrary{}
\usepgfplotslibrary{}

% Bibliography
% N.B.: the counter `cite' is used to count the number of citations.
\newcommand{\bibfile}{bib/refs}
\newcounter{cite}
\pretocmd{\cite}{\stepcounter{cite}}{}{}

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
% Mathematics
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{cases}
\RequirePackage{empheq}
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
\newcommand{\C}{\mathbb{C}}
\newcommand{\F}{\mathbb{F}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\Z}{\mathbb{Z}}
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

% Glossaries
\usepackage[acronym]{glossaries-extra}
\setabbreviationstyle[acronym]{long-short}
\glsdisablehyper
\newacronym{acq}{ACQ}{Abadie constraint qualification}
\newacronym{auc}{AUC}{area under the \glsfmtshort{roc} curve}
\newacronym{bbo}{BBO}{black-box optimization}
\newacronym{cdt}{CDT}{Celis-Dennis-Tapia}
\newacronym{cpld}{CPLD}{constant positive linear dependence constraint qualification}
\newacronym{cpu}{CPU}{central processing unit}
\newacronym{crcq}{CRCQ}{constant rank constraint qualification}
\newacronym{dfo}{DFO}{derivative-free optimization}
\newacronym{dfp}{DFP}{Davidon-Fletcher-Powell}
\newacronym{gcq}{GCQ}{Guignard constraint qualification}
\newacronym{gps}{GPS}{generalized pattern search}
\newacronym{kkt}{KKT}{Karush-Kuhn-Tucker}
\newacronym{lcq}{LCQ}{linearity constraint qualification}
\newacronym{licq}{LICQ}{linear independence constraint qualification}
\newacronym{mads}{MADS}{mesh adaptive direct search}
\newacronym{mdo}{MDO}{multi-disciplinary design optimization}
\newacronym{mfcq}{MFCQ}{Mangasarian-Fromovitz constraint qualification}
\newacronym{psb}{PSB}{Powell symmetric Broyden}
\newacronym{qncq}{QNCQ}{quasi-normality constraint qualification}
\newacronym{rbf}{RBF}{radial basis function}
\newacronym{roc}{ROC}{receiver operating characteristic}
\newacronym{sc}{SC}{Slater's condition}
\newacronym{slqp}{SLQP}{sequential linear-quadratic programming}
\newacronym{soc}{SOC}{second-order correction}
\newacronym{sqp}{SQP}{sequential quadratic programming}
\newacronym{sqm}{SQM}{sequence of quadratic models}
\newacronym{svc}{SVC}{support vector classification}
\newacronym{svm}{SVM}{support vector machine}
\newacronym{tcg}{TCG}{truncated conjugate gradient}

% QR codes
\ifdraft{\PassOptionsToPackage{draft}{qrcode}}{}
\RequirePackage[nolinks]{qrcode}
\qrset{level=Q,version=3}  % Up to 47 alphanumeric characters
% Make QR codes clickable (the document is compiled with XeLaTeX)
\setlength{\XeTeXLinkMargin}{1pt}
\let\old@qrcode\qrcode\relax
\def\qrcode#1{\href{#1}{\XeTeXLinkBox{\old@qrcode{#1}}}}
