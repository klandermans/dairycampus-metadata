#!/usr/bin/env python3
"""Build the Dairy Campus Data Descriptor as a typeset LaTeX/PDF article.

Zenodo sanitises the HTML record description (all ``style``, ``colgroup`` and
``id`` attributes are stripped), so a professional layout with real
mathematical notation, uniform table widths and internal navigation is only
possible in an attached document.  This script renders the 19 metadata tables
from the master data dictionary into ``article/dairy_campus_data_descriptor.tex``
and compiles it with ``tectonic``.

Only calculations that are documented in the metadata dictionary (i.e. that
are implemented in the SQL tables/views) are typeset as equations.
"""
import re
import shutil
import subprocess
import sys
from pathlib import Path

import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
DICT_CSV = ROOT / "zenodo_deposit_files" / "01_Dairy_Campus_Master_Data_Dictionary.csv"
OUT_DIR = ROOT / "article"
TEX_NAME = "dairy_campus_data_descriptor"

DOI = "10.5281/zenodo.24092174"

DATASET_TITLES = {
    "TVL_total": "Master daily integrated cow summary",
    "Hokofarm_SAC_concentrates": "Automatic concentrate feeder transactions",
    "Hokofarm_RIC": "Roughage intake control (RIC) visit transactions",
    "TVL_RIC_intake_dm": "Daily roughage intake and dry matter integration",
    "Triomatic_RIC_load": "Trioliet Triomatic feeding robot loading records",
    "Triomatic_RIC_drop": "Trioliet Triomatic feeding robot trough deliveries",
    "GEA_gates": "GEA separation and smart gate passages",
    "GEA_milkings": "GEA milking transactions",
    "TMR_Trioliet_cowconnect_mix": "CowConnect mixer wagon rations",
    "Velos_behaviour": "Nedap Velos behaviour intervals",
    "Velos_behaviour_day": "Nedap Velos daily behaviour budgets",
    "TMR_Trioliet_cowconnect_drop": "CowConnect feed distribution drops",
    "DC_DM_content": "Laboratory dry matter content (drying oven)",
    "Greenfeed_summarized_data": "GreenFeed enteric emission summaries",
    "Greenfeed_feed_aggregrated": "GreenFeed bait feed drops",
    "Weatherstation": "Dairy Campus meteorological station",
    "Missing_data": "Data completeness audit matrix",
    "Environment_barn_Animal_day": "Barn environment and animal daily profile",
    "Environment_barn_Animal_experim": "Experimental cohort animal daily records",
}

MISSING = {"", "?", "nan", "n/a", "na", "none", "-"}


# --------------------------------------------------------------------------
# helpers
# --------------------------------------------------------------------------
TEX_ESCAPES = {
    "\\": r"\textbackslash{}",
    "&": r"\&",
    "%": r"\%",
    "$": r"\$",
    "#": r"\#",
    "_": r"\_",
    "{": r"\{",
    "}": r"\}",
    "~": r"\textasciitilde{}",
    "^": r"\textasciicircum{}",
    "<": r"\textless{}",
    ">": r"\textgreater{}",
}


def esc(text: str) -> str:
    return "".join(TEX_ESCAPES.get(ch, ch) for ch in text)


def clean(value) -> str:
    s = "" if pd.isna(value) else str(value).strip()
    return "" if s.lower() in MISSING else s


def ident(text: str) -> str:
    """Typeset an identifier in monospace with line-break opportunities."""
    out = esc(text)
    out = out.replace(r"\_", r"\_\allowbreak{}").replace(".", r".\allowbreak{}")
    out = re.sub(r"(?<=[a-z])(?=[A-Z])", r"\\allowbreak{}", out)
    return r"\texttt{" + out + "}"


def prose(text: str) -> str:
    """Escape free text; allow breaks inside long identifiers it contains."""
    out = esc(text)
    return out.replace(r"\_", r"\_\allowbreak{}")


def unit_tex(unit: str) -> str:
    u = clean(unit).rstrip("?").strip()
    if not u:
        return r"\textemdash"
    mapping = {
        "Ja/Nee": "yes/no",
        "number": r"\textendash",
        "short text": "text",
        "°C": r"\si{\degreeCelsius}",
        "° Degree": r"\si{\degree}",
        "%": r"\si{\percent}",
        "mg/dL": r"\si{\milli\gram\per\deci\litre}",
        "1000 cells/mL": r"$10^{3}$\,cells\,mL$^{-1}$",
        "Watt/m2": r"\si{\watt\per\square\metre}",
        "meter/sec": r"\si{\metre\per\second}",
        "Liter/sec": r"\si{\litre\per\second}",
        "sec": r"\si{\second}",
        "kg": r"\si{\kilogram}",
        "gram": r"\si{\gram}",
    }
    return mapping.get(u, prose(u))


def origin_tex(mtype: str) -> str:
    m = clean(mtype).lower()
    if m == "measured":
        return "Measured"
    if m == "calculated":
        return "Derived"
    return r"\textemdash"


def derivation_tex(row) -> str:
    calc = clean(row["calculation_description"])
    src = clean(row["calculation_source"])
    if "?" in calc:  # open editorial questions are not published
        calc = ""
    parts = []
    if calc:
        parts.append(prose(calc))
    if src and "?" not in src:
        parts.append(r"\textit{Source:} " + ident(src))
    return r" \newline ".join(parts) if parts else r"\textemdash"


def description_tex(row) -> str:
    d = clean(row["description_en"])
    return prose(d) if d else r"\textemdash"


# --------------------------------------------------------------------------
# document
# --------------------------------------------------------------------------
PREAMBLE = r"""
\documentclass[10pt,a4paper]{article}
\usepackage[a4paper,top=22mm,bottom=24mm,left=20mm,right=20mm,headheight=14pt]{geometry}
\usepackage{amsmath,amssymb}
\usepackage{fontspec}
\usepackage{microtype}
\usepackage[table]{xcolor}
\usepackage{array,longtable,booktabs}
\usepackage{siunitx}
\usepackage{enumitem}
\usepackage{titlesec}
\usepackage{fancyhdr}
\usepackage{caption}
\usepackage[hidelinks,bookmarksnumbered,bookmarksopen]{hyperref}

\definecolor{accent}{HTML}{1F4E79}
\definecolor{rowgrey}{HTML}{F3F5F8}
\hypersetup{colorlinks=true,linkcolor=accent,urlcolor=accent,citecolor=accent,
  pdftitle={Dairy Campus Research Data Platform: Data Descriptor},
  pdfauthor={Bert Klandermans; Fedde de Jong}}

\titleformat{\section}{\sffamily\large\bfseries\color{accent}}{\thesection}{0.8em}{}
\titleformat{\subsection}{\sffamily\normalsize\bfseries\color{accent}}{\thesubsection}{0.8em}{}
\titlespacing*{\section}{0pt}{14pt}{6pt}
\titlespacing*{\subsection}{0pt}{12pt}{4pt}

\captionsetup{font=small,labelfont={bf,sf},justification=raggedright,singlelinecheck=false}
\setlist{itemsep=2pt,topsep=4pt}
\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt}

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.4pt}
\fancyhead[L]{\small\sffamily Dairy Campus Research Data Platform \textemdash{} Data Descriptor}
\fancyhead[R]{\small\sffamily\hyperlink{toc}{Contents}}
\fancyfoot[C]{\small\sffamily\thepage}

% ---- uniform data-dictionary layout (identical for all 19 tables) ----
\setlength{\tabcolsep}{4pt}
\newlength{\dictw}
\setlength{\dictw}{\dimexpr\textwidth-12\tabcolsep\relax}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1\dictw}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1\dictw}}
\newcommand{\dicthead}{%
  \toprule
  \sffamily\bfseries Variable &\sffamily\bfseries Type &\sffamily\bfseries Unit &
  \sffamily\bfseries Origin &\sffamily\bfseries Description &\sffamily\bfseries Derivation / source\\
  \midrule}

\sisetup{detect-all}
"""


EQUATIONS = r"""
\section{Calculation methodology}\label{sec:methods}

This section formalises the derived variables that are computed inside the SQL
tables and views of the platform. Only calculations documented in the data
dictionary are included; the variable names given in parentheses refer to the
columns in Section~\ref{sec:dictionaries}. Time stamps are denoted $t$, masses
$M$ (\si{\kilogram}), and the index $d$ refers to a calendar day.

\subsection{Roughage intake per visit and per day}
The Hokofarm RIC troughs are mounted on load cells. The intake and duration of
visit $v$, and the daily fresh intake of roughage fraction
$f \in \{1,2,3,4\}$ (\texttt{rv1.Prod}\,--\,\texttt{rv4.Prod}), are
\begin{equation}
  I_{v} = M_{v}^{\text{start}} - M_{v}^{\text{end}}, \qquad
  \Delta t_{v} = t_{v}^{\text{end}} - t_{v}^{\text{start}}, \qquad
  I_{f,d} = \sum_{v \in \mathcal{V}_{f,d}} I_{v},
  \label{eq:ric}
\end{equation}
where $\mathcal{V}_{f,d}$ is the set of visits of a cow to troughs holding
fraction $f$ on day $d$.

\subsection{Correction for water added in the feed kitchen}
Water is added to the ration in the Trioliet Triomatic feed kitchen. Intake
excluding added water (\texttt{rv$f$.ProdExclWater}, \texttt{opnMinWater};
view \texttt{VL\_Totaal\_sub\_ric\_opn\_prod}) is
\begin{equation}
  I_{f,d}^{\text{excl}} \;=\;
  \frac{M_{\text{loaded}} - M_{\text{water}}}{M_{\text{loaded}}}\; I_{f,d},
  \label{eq:water}
\end{equation}
with $M_{\text{loaded}}$ the total mass loaded into the mixer and
$M_{\text{water}}$ the mass of water added to that batch.

\subsection{Dry matter intake}
Weekly dry matter contents $\mathrm{DM}_{f}$ (\si{\percent}) are determined
gravimetrically in the drying oven (\texttt{VL\_totaal\_droogstoof}). Total
daily dry matter intake (\texttt{tot.opnDs}, \si{\kilogram\,DM\per\day}) is
\begin{equation}
  \mathrm{DMI}_{d} \;=\; \sum_{f=1}^{4} I_{f,d}^{\text{excl}}\,
  \frac{\mathrm{DM}_{f}}{100}.
  \label{eq:dmi}
\end{equation}

\subsection{Concentrate feeding}
For the computerised concentrate stations, the residual (not consumed)
concentrate (\texttt{SumVoeRst}) follows from the programmed allowance
(\texttt{SumVoeGft}) and the consumed amount (\texttt{SumVoeOpnm}):
\begin{equation}
  C_{d}^{\text{rest}} = C_{d}^{\text{granted}} - C_{d}^{\text{intake}} .
  \label{eq:conc}
\end{equation}

\subsection{Yield-weighted milk composition}
Milk recording (CRV/MPR) concentrations are aggregated per ISO calendar week $w$
as yield-weighted means (\texttt{mpr\_week.*}; view \texttt{VL\_Dier\_Datum\_Crv}):
\begin{equation}
  \bar{c}_{w} \;=\;
  \frac{\displaystyle\sum_{j \in \mathcal{J}_{w}} c_{j}\, Y_{j}}
       {\displaystyle\sum_{j \in \mathcal{J}_{w}} Y_{j}},
  \qquad c \in \{\text{fat},\ \text{protein},\ \text{lactose},\ \text{urea},\ \text{SCC}\},
  \label{eq:mpr}
\end{equation}
where $\mathcal{J}_{w}$ is the set of test milkings in week $w$, $c_{j}$ the
concentration and $Y_{j}$ (\si{\kilogram}) the milk yield of milking $j$.

\subsection{Daily behaviour budgets}
Nedap Velos intervals $k$ carry a behaviour state $s_{k} \in \{0,1,2,3\}$
(0 other active, 1 inactive, 2 ruminating, 3 eating). The daily time budget per
state (\texttt{overig}, \texttt{nietactief}, \texttt{herkouwen},
\texttt{vreten}) and the total (\texttt{total}) are
\begin{equation}
  T_{s,d} = \sum_{k \in \mathcal{K}_{d}} \Delta t_{k}\, \mathbf{1}[s_{k}=s],
  \qquad
  T_{d} = \sum_{s=0}^{3} T_{s,d},
  \label{eq:velos}
\end{equation}
with $\mathcal{K}_{d}$ the intervals recorded on day $d$ and $\mathbf{1}[\cdot]$
the indicator function.

\subsection{Lactation and reproduction timing}
For a record on date $t$ (all quantities in days):
\begin{align}
  \mathrm{DIM}           &= t - t_{\text{calving}}
      && \text{(\texttt{LacDgn}, \texttt{IMDim}, \texttt{DaysInLactation})} \label{eq:dim}\\
  A                      &= t - t_{\text{birth}}
      && \text{(\texttt{AgeDays})} \label{eq:age}\\
  t_{\text{exp.\,calving}} &= t_{\text{insemination}} + 280
      && \text{(\texttt{VrwKlfDat}, \texttt{ExpecCalvingDate})} \label{eq:expcalv}\\
  D_{\text{to calving}}  &= t_{\text{exp.\,calving}} - t
      && \text{(\texttt{VrwDgn})} \label{eq:vrwdgn}
\end{align}
"""


def build_tex(df: pd.DataFrame, doi_str: str = DOI) -> str:
    datasets = list(dict.fromkeys(df["dataset_name"]))
    n_vars = len(df)
    L = [PREAMBLE, r"\begin{document}"]

    # ---- title block ----
    L.append(r"""
\begin{center}
  {\sffamily\bfseries\LARGE\color{accent} Dairy Campus Research Data Platform\par}
  \vspace{4pt}
  {\sffamily\large Data Descriptor, Standardised Metadata Dictionaries\\ and Calculation Methodology\par}
  \vspace{10pt}
  {\normalsize Bert Klandermans \quad Fedde de Jong\par}
  \vspace{2pt}
  {\small\itshape Dairy Campus, Wageningen University \& Research, Leeuwarden, The Netherlands\par}
  \vspace{4pt}
  {\small DOI: \href{https://doi.org/""" + doi_str + "}{" + doi_str + r"""} \quad\textbar\quad Licence: CC BY 4.0\par}
\end{center}
\vspace{6pt}
\noindent\rule{\textwidth}{0.4pt}
\begin{abstract}
\noindent
Dairy Campus (Wageningen University \& Research, Leeuwarden) operates a
multi-sensor experimental dairy herd for research on nutrition, feed efficiency,
enteric methane mitigation, animal welfare and precision livestock farming. This
data descriptor documents the research data platform: """ + f"{len(datasets)}" + r"""
datasets comprising """ + f"{n_vars}" + r""" variables, with their data types,
units, measurement origin and derivation. Derived quantities computed in the SQL
layer (water correction of roughage intake, dry matter intake, yield-weighted milk
composition, behaviour budgets and lactation timing) are given in closed form.
\end{abstract}
\noindent\rule{\textwidth}{0.4pt}
""")

    L.append(r"\hypertarget{toc}{}" "\n" r"\tableofcontents" "\n" r"\clearpage")

    # ---- background ----
    L.append(r"""
\section{Facility and sensor infrastructure}
Dairy Campus houses an experimental herd of approximately 500 Holstein Friesian
cows. The platform continuously ingests data from the following systems:
\begin{itemize}
  \item \textbf{Hokofarm RIC troughs} \textendash{} individual roughage intake bins on load cells with RFID identification.
  \item \textbf{Trioliet Triomatic} \textendash{} automated feed kitchen and feeding robot; loading and trough deliveries.
  \item \textbf{Hokofarm/SAC concentrate stations} \textendash{} computerised dispensing of up to four concentrates (A\textendash D).
  \item \textbf{GEA milking systems and smart gates} \textendash{} milk yield, milking duration, body weight and routing.
  \item \textbf{Nedap Velos smarttags} \textendash{} behaviour classification into eating, ruminating, inactive and other active.
  \item \textbf{C-Lock GreenFeed} \textendash{} enteric CH$_4$ and CO$_2$ fluxes during voluntary bait-fed visits.
  \item \textbf{Weather station} \textendash{} ambient temperature, humidity, wind, precipitation and radiation.
\end{itemize}
Laboratory drying-oven dry matter analyses and official milk recording (CRV/MPR)
complement the sensor streams.
""")

    L.append(EQUATIONS)

    # ---- overview table with links ----
    L.append(r"""
\section{Dataset overview}\label{sec:overview}
Table~\ref{tab:overview} lists all datasets; names link to the corresponding data dictionary.
\begingroup\small
\rowcolors{2}{rowgrey}{white}
\begin{longtable}{>{\raggedleft\arraybackslash}p{0.04\textwidth}
                  >{\raggedright\arraybackslash}p{0.36\textwidth}
                  >{\raggedright\arraybackslash}p{0.40\textwidth}
                  >{\raggedleft\arraybackslash}p{0.08\textwidth}}
\caption{Datasets of the Dairy Campus research data platform.}\label{tab:overview}\\
\toprule
\sffamily\bfseries \# & \sffamily\bfseries Dataset & \sffamily\bfseries Content & \sffamily\bfseries Variables\\
\midrule\endfirsthead
\toprule
\sffamily\bfseries \# & \sffamily\bfseries Dataset & \sffamily\bfseries Content & \sffamily\bfseries Variables\\
\midrule\endhead
\bottomrule\endfoot
""")
    for i, ds in enumerate(datasets, 1):
        n = int((df["dataset_name"] == ds).sum())
        L.append(
            f"{i} & \\hyperref[ds:{ds}]{{{ident(ds)}}} & "
            f"{esc(DATASET_TITLES.get(ds, ''))} & {n}\\\\"
        )
    L.append(r"\end{longtable}\endgroup")

    # ---- dictionaries ----
    L.append(r"""
\clearpage
\section{Data dictionaries}\label{sec:dictionaries}
All dictionaries share an identical layout. \emph{Origin} indicates whether a
variable is measured by a sensor or laboratory, or derived in the SQL layer;
derivations refer to the equations in Section~\ref{sec:methods}. A dash
(\textemdash) denotes information that is not documented.
""")
    for ds in datasets:
        sub = df[df["dataset_name"] == ds]
        src = clean(sub["source_table"].iloc[0])
        title = DATASET_TITLES.get(ds, ds)
        L.append(f"\\subsection{{{esc(title)}}}\\label{{ds:{ds}}}")
        meta = f"\\textbf{{Dataset:}} {ident(ds)}"
        if src:
            meta += f" \\quad\\textbar\\quad \\textbf{{Source table:}} {ident(src)}"
        meta += f" \\quad\\textbar\\quad \\textbf{{Variables:}} {len(sub)}"
        L.append(r"{\small " + meta + r"}\par")
        L.append(r"\begingroup\footnotesize\rowcolors{2}{rowgrey}{white}")
        L.append(r"\begin{longtable}{L{0.22}C{0.08}C{0.10}C{0.09}L{0.30}L{0.21}}")
        L.append(f"\\caption{{Data dictionary of \\texttt{{{esc(ds)}}}.}}\\\\")
        L.append(r"\dicthead\endfirsthead")
        L.append(r"\multicolumn{6}{l}{\footnotesize\itshape continued}\\ \dicthead\endhead")
        L.append(r"\bottomrule\endfoot")
        for _, r in sub.iterrows():
            label = clean(r["name_en"])
            var = ident(clean(r["column_name"]))
            if label:
                var += r"\newline " + prose(label)
            dtype = esc(clean(r["data_type"])) or r"\textemdash"
            L.append(
                f"{var} & {dtype} & {unit_tex(r['unit'])} & {origin_tex(r['measurement_type'])} & "
                f"{description_tex(r)} & {derivation_tex(r)}\\\\"
            )
        L.append(r"\end{longtable}\endgroup")

    # ---- citation ----
    L.append(r"""
\section{Data availability and citation}
The machine-readable dictionary (CSV, XLSX), per-dataset CSV files and the SQL
calculation layer (views, stored procedures and functions) are deposited with this
descriptor. Please cite:
\begin{quote}\small
Klandermans, B., \& de Jong, F. (2026). \emph{Dairy Campus Research Data Platform:
Data Descriptor, Standardised Metadata Dictionaries and Calculation Methodology}.
Zenodo. \href{https://doi.org/""" + DOI + "}{https://doi.org/" + DOI + r"""}
\end{quote}
\end{document}
""")
    return "\n".join(L)


def main() -> int:
    df = pd.read_csv(DICT_CSV)
    OUT_DIR.mkdir(exist_ok=True)
    tex_path = OUT_DIR / f"{TEX_NAME}.tex"
    tex_path.write_text(build_tex(df), encoding="utf-8")
    print(f"Wrote {tex_path}")

    engine = shutil.which("tectonic")
    if not engine:
        print("tectonic not found; install with `brew install tectonic`.", file=sys.stderr)
        return 1
    res = subprocess.run([engine, "--keep-logs", tex_path.name], cwd=OUT_DIR)
    if res.returncode == 0:
        pdf_path = OUT_DIR / (TEX_NAME + ".pdf")
        dest_pdf = ROOT / "zenodo_deposit_files" / "00_Dairy_Campus_Data_Descriptor.pdf"
        shutil.copy2(pdf_path, dest_pdf)
        print(f"Built {pdf_path}")
        print(f"Copied to {dest_pdf}")
    return res.returncode


if __name__ == "__main__":
    sys.exit(main())
