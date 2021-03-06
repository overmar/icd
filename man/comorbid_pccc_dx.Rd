% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/comorbid_pccc.R
\name{comorbid_pccc_dx}
\alias{comorbid_pccc_dx}
\alias{comorbid_pccc_pcs}
\alias{icd9_comorbid_pccc_dx}
\alias{icd10_comorbid_pccc_dx}
\alias{icd9_comorbid_pccc_pcs}
\alias{icd10_comorbid_pccc_pcs}
\title{Calculate pediatric complex chronic conditions (PCCC) comorbidities}
\usage{
comorbid_pccc_dx(x, visit_name = get_visit_name(x),
  icd_name = get_icd_name(x), short_code = guess_short(x, icd_name =
  icd_name), return_df = FALSE, return_binary = FALSE, ...)

comorbid_pccc_pcs(x, visit_name = get_visit_name(x), icd_name,
  return_df = FALSE, return_binary = FALSE, ...)

icd9_comorbid_pccc_dx(x, visit_name = NULL, icd_name = NULL,
  short_code = guess_short(x, icd_name = icd_name), return_df = FALSE,
  return_binary = FALSE, ..., abbrev_names = TRUE)

icd10_comorbid_pccc_dx(x, visit_name = NULL, icd_name = NULL,
  short_code = guess_short(x, icd_name = icd_name), return_df = FALSE,
  return_binary = FALSE, ..., abbrev_names = TRUE)

icd9_comorbid_pccc_pcs(x, visit_name = get_visit_name(x),
  icd_name = get_icd_pc_name(x), return_df = FALSE,
  return_binary = FALSE, ..., abbrev_names = TRUE)

icd10_comorbid_pccc_pcs(x, visit_name = get_visit_name(x), icd_name,
  return_df = FALSE, return_binary = FALSE, ..., abbrev_names = TRUE)
}
\arguments{
\item{x}{\code{data.frame} containing a column of patient-visit identifiers
and a column of ICD codes. The \code{data.frame} may be in \sQuote{long} or
\sQuote{wide} format, like the example \code{\link{vermont_dx}}
and \code{\link{uranium_pathology}} data.}

\item{visit_name}{The name of the column in the data frame which contains the
patient or visit identifier. Typically this is the visit identifier, since
patients come leave and enter hospital with different ICD-9 codes. It is a
character vector of length one. If left empty, or \code{NULL}, then an
attempt is made to guess which field has the ID for the patient encounter
(not a patient ID, although this can of course be specified directly). The
guesses proceed until a single match is made. Data frames may be wide with
many matching fields, so to avoid false positives, anything but a single
match is rejected. If there are no successful guesses, and \code{visit_id}
was not specified, then the first column of the data frame is used.}

\item{icd_name}{The name of the column in the \code{data.frame} which
contains the ICD codes. This is a character vector of length one. If it is
\code{NULL}, \code{icd9} will attempt to guess the column name, looking for
progressively less likely possibilities until it matches a single column.
Failing this, it will take the first column in the data frame. Specifying
the column using this argument avoids the guesswork.}

\item{short_code}{single logical value which determines whether the ICD-9
code provided is in short (\code{TRUE}) or decimal (\code{FALSE}) form.
Where reasonable, this is guessed from the input data.}

\item{return_df}{single logical value, if \code{TRUE}, return 'tidy' data,
i.e., the result is a data frame with the first column being the
\code{visit_id}, and the second being the count. If \code{visit_id} was a
factor or named differently in the input, this is preserved.}

\item{return_binary}{Single logical value, if \code{TRUE}, the returned
\code{matrix} or \code{data.frame} will be composed of \code{1} and
\code{0}, instead of \code{TRUE} and \code{FALSE}, respectively. This
conversion can also be done by the internal functions
\code{icd:::logical_to_binary} and \code{icd:::binary_to_logical}, or using
other tools, e.g. \code{apply(x, 2, as.integer)}}

\item{...}{Arguments passed through to \code{comorbid}}

\item{abbrev_names}{single logical value that defaults to \code{TRUE}, in
which case the shorter human-readable names stored in e.g.
\code{ahrqComorbidNamesAbbrev} are applied to the data frame column names.}
}
\description{
Unlike with ICD-9 and ICD-10 diagnostic codes, 'icd' doesn't
currently have a method for guessing which fields are procedure
codes, so \code{icd_name} must be specified for the \code{_pcs}
functions.
}
\section{Functions}{
\itemize{
\item \code{comorbid_pccc_pcs}: Calculate the PCCC comorbidities based
on procedure codes,

\item \code{icd9_comorbid_pccc_dx}: Calculate PCCC comorbidities from ICD-9
diagnosis codes

\item \code{icd10_comorbid_pccc_dx}: Calculate PCCC comorbidities from ICD-10
diagnosis codes

\item \code{icd9_comorbid_pccc_pcs}: Calculate PCCC comorbidities from ICD-9
procedure codes

\item \code{icd10_comorbid_pccc_pcs}: Calculate PCCC comorbidities from ICD-10
procedure codes
}}

\examples{
# not pediatric data, but let's look for this example
head(icd9_comorbid_pccc_dx(vermont_dx))
# Six random codes from each PCCC procedure code map. 'icd' will use
# an heuristic to guess whether ICD-9 or ICD-10:
pts <- data.frame(
  encounters = c(10, 11, 12),
  icd9_pcs = c("0152", "304", "0050"),
  icd10_pcs = c("0B110Z4", "02YA0Z2", "031209D")
)
comorbid_pccc_pcs(pts, icd_name = "icd9_pcs", return_binary = TRUE)
comorbid_pccc_pcs(pts, icd_name = "icd10_pcs", return_binary = TRUE)

# All ICD-9 procedure codes are numeric, some ICD-10 procedure codes
# are numeric, so best to call functions directly:
pts <- data.frame(encounters = c(100), icd10_pcs = c("0016070"))
icd10_comorbid_pccc_pcs(pts, icd_name = "icd10_pcs")
}
\seealso{
Other comorbidity computations: \code{\link{comorbid_hcc}},
  \code{\link{comorbid}}

Other comorbidities: \code{\link{comorbid_hcc}},
  \code{\link{comorbid}}, \code{\link{icd10_map_ahrq_pcs}},
  \code{\link{icd9_map_ahrq}}, \code{\link{icd9_map_elix}},
  \code{\link{icd9_map_hcc}}, \code{\link{icd9_map_pccc}},
  \code{\link{icd9_map_quan_deyo}},
  \code{\link{icd9_map_quan_elix}},
  \code{\link{icd9_map_single_ccs}}
}
\concept{comorbidities}
\concept{comorbidity computations}
