% This document class provides a simple memo for LaTeX users.
% It is based on article.cls and inherits most of the functionality
% that class.
% 
% Author: Rob Oakes, Copyright 2010.  Released under the LGPL, version 3.
% A copy of the LGPL can be found at http://www.gnu.org/licenses/lgpl.html

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdoc_document}[2013/06/21 - Small Army Of Nerds Corp. Memo Class, Including Logo]
\RequirePackage{palatino}
\RequirePackage{graphicx}

% Load the Base Class
\LoadClassWithOptions{article}

% Begin Requirements
\RequirePackage{ifthen}

\def\@documentnumber{\relax}
\newcommand{\documentnumber}[1]{\gdef\@documentnumber{#1}}

\def\@reviewer{\relax}
\newcommand{\reviewer}[1]{\gdef\@reviewer{#1}}

\def\@approver{\relax}
\newcommand{\approver}[1]{\gdef\@approver{#1}}

\def\@memoto{\relax}
\newcommand{\memoto}[1]{\gdef\@memoto{#1}}

\def\@memofrom{\relax}
\newcommand{\memofrom}[1]{\gdef\@memofrom{#1}}

\def\@memosubject{\relax}
\newcommand{\memosubject}[1]{\gdef\@memosubject{#1}}

\def\@memodate{\relax}
\newcommand{\memodate}[1]{\gdef\@memodate{#1}}

\def\@documentlogo{\relax}
\newcommand{\logo}[1]{\gdef\@documentlogo{\protect #1}}

\def\@memodocnumber{\relax}
\newcommand{\memodocnumber}[1]{\gdef\@memodocnumber{#1}}

\def\@letterheadaddress{\relax}
\newcommand{\lhaddress}[1]{\gdef\@letterheadaddress{#1}}

% Custom Document Formatting
\newcommand\decorativeline[1][1pt]{
	\par\noindent%
	\rule[0.5ex]{\linewidth}{#1}\par
}

% Set the Paper Size and margins
\RequirePackage{geometry}
\geometry{margin=1.0in}

\renewcommand{\maketitle}{\makememotitle}
\newcommand\makememotitle{
	\ifthenelse{\equal{\@memologo}{\relax}}{}
	{ % Create With Logo
	\begin{minipage}[t]{1\columnwidth}%
		\begin{flushright}
			\vspace{-0.6in}
			\@memologo
			\vspace{0.5in}
		\par\end{flushright}%
	\end{minipage}
	}
	
	% To, From, Subject Block
	\begin{description}
		\ifthenelse{\equal{\@memoto}{\relax}}{}{\item [{To:}] \@memoto}
		\ifthenelse{\equal{\@memofrom}{\relax}}{}{\item [{From:}] \@memofrom}
		\ifthenelse{\equal{\@memosubject}{\relax}}{}{\item [{Subject:}] \@memosubject}
		\ifthenelse{\equal{\@memodocnumber}{\relax}}{}{\item [{Document Number:}] \@memodocnumber}
		\ifthenelse{\equal{\@memodate}{\relax}}{}{\item [{Date:}] \@memodate}
	\end{description}
	\decorativeline\bigskip{}
}

\newlength{\drop}

\newcommand*{\titleSDOC}{\begingroup%
\pagestyle{empty}
\setlength{\drop}{0.05\textheight}
%\vspace*{\baselineskip}
\vfill
\hbox{%
  \hspace*{0.05\textwidth}%
  \rule{1pt}{\textheight}
  \hspace*{0.05\textwidth}%
  \parbox[b]{0.85\textwidth}{
    \vbox{%
      %\vspace{\drop}
      \parbox[t]{0.8\textwidth}{
        {\noindent\LARGE\bfseries \@title}\\[1\baselineskip]
        {\Large\itshape \@documentnumber}\\[4\baselineskip]
        {\large \textbf{Author:}}\\[0.5\baselineskip]
        {\large \@author}\\[\baselineskip]
        \ifthenelse{\equal{\@reviewer}{\relax}}{}{
          {\large \textbf{Reviewed By:}}\\[0.5\baselineskip]
          {\large \@reviewer}\\[\baselineskip]
        }
        \ifthenelse{\equal{\@approver}{\relax}}{}{
          {\large \textbf{Approved By:}}\\[0.5\baselineskip]
          {\large \@approver}\\[2\baselineskip]
        }
        {\large Issued June 21, 2013}
      }
      %\vspace{0.5\textheight}
      \vfill
      \begin{flushright}
      	\@documentlogo
      \par\end{flushright}%
    }% end of vbox
  }% end of parbox
}% end of hbox
\vfill
\null
\endgroup}
