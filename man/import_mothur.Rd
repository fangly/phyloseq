% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/IO-methods.R
\name{import_mothur}
\alias{import_mothur}
\title{General function for importing mothur data files into phyloseq.}
\usage{
import_mothur(mothur_list_file = NULL, mothur_group_file = NULL,
  mothur_tree_file = NULL, cutoff = NULL, mothur_shared_file = NULL,
  mothur_constaxonomy_file = NULL, parseFunction = parse_taxonomy_default)
}
\arguments{
\item{mothur_list_file}{(Optional). The list file name / location produced by \emph{mothur}.}

\item{mothur_group_file}{(Optional). The name/location of the group file produced
 by \emph{mothur}'s \code{make.group()} function. It contains information
 about the sample source of individual sequences, necessary for creating a
 species/taxa abundance table (\code{otu_table}). See
 \code{http://www.mothur.org/wiki/Make.group}}

\item{mothur_tree_file}{(Optional).
 A tree file, presumably produced by \emph{mothur},
 and readable by \code{\link{read_tree}}.
 The file probably has extension \code{".tree"}.}

\item{cutoff}{(Optional). A character string indicating the cutoff value, (or \code{"unique"}),
 that matches one of the cutoff-values used to produce the OTU clustering
 results contained within the list-file created by \emph{mothur} (and specified
 by the \code{mothur_list_file} argument). The default
 is to take the largest value among the cutoff values contained in the list
 file. If only one cutoff is included in the file, it is taken and this
 argument does not need to be specified. Note that the \code{cluster()}
 function within the \emph{mothur} package will often produce a list file
 with multiple cutoff values, even if a specific cutoff is specified. It is
 suggested that you check which cutoff values are available in a given list
 file using the \code{\link{show_mothur_cutoffs}} function.}

\item{mothur_shared_file}{(Optional). A
\href{http://www.mothur.org/wiki/Shared_file}{shared file}
produced by \emph{mothur}.}

\item{mothur_constaxonomy_file}{(Optional). A
 \href{http://www.mothur.org/wiki/Constaxonomy_file}{consensus taxonomy file}
 produced by \emph{mothur}.}

\item{parseFunction}{(Optional). A specific function used for parsing the taxonomy string.
 See \code{\link{parse_taxonomy_default}} for an example. If the default is
 used, this function expects a semi-colon delimited taxonomy string, with
 no additional rank specifier. A common taxonomic database is GreenGenes,
 and in recent versions its taxonomy entries include a prefix, which is best cleaved
 and used to precisely label the ranks (\code{\link{parse_taxonomy_greengenes}}).}
}
\value{
The object class depends on the provided arguments.
 A phyloseq object is returned if enough data types are provided.
 If only one data component can be created from the data, it is returned.

 FASTER (recommended for larger data sizes):

 If only a \code{mothur_constaxonomy_file} is provided,
 then a  \code{\link{taxonomyTable-class}} object is returned.

 If only a \code{mothur_shared_file} is provided,
 then an \code{\link{otu_table}} object is returned.

 SLOWER (but fine for small file sizes):

 The list and group file formats are extremely inefficient for large datasets,
 and they are not recommended. The mothur software provides tools for
 converting to other file formats, such as a so-called ``shared'' file.
 You should provide a shared file, or group/list files, but not
 both at the same time.
 If only a list and group file are provided,
 then an \code{otu_table} object is returned.
 Similarly, if only a list and tree file are provided,
 then only a tree is returned (\code{\link[ape]{phylo}}-class).
}
\description{
Technically all parameters are optional,
but if you don't provide any file connections, then nothing will be returned.
While the \code{list} and \code{group} files are the first two arguments
for legacy-compatibility reasons, we don't recommend that you use these
file types with modern (large) datasets. They are comically inefficient, as
they store the name of every sequencing read in both files. The \emph{mothur}
package provides conversions utilities to create other more-efficient formats,
which we recommend, like
the \href{http://www.mothur.org/wiki/Shared_file}{shared file} for an OTU table.
Alternatively, mothur also provides a utility to create a biom-format file
that is independent of OTU clustering platform. Biom-format files
should be imported not with this function, but with \code{\link{import_biom}}.
The resulting objects after import should be \code{\link{identical}} in R.
}
\examples{
# # The following example assumes you have downloaded the esophagus example
# # dataset from the mothur wiki:
# # "http://www.mothur.org/wiki/Esophageal_community_analysis"
# # "http://www.mothur.org/w/images/5/55/Esophagus.zip"
# # The path on your machine may (probably will) vary
# mothur_list_file  <- "~/Downloads/mothur/Esophagus/esophagus.an.list"
# mothur_group_file <- "~/Downloads/mothur/Esophagus/esophagus.good.groups"
# mothur_tree_file  <- "~/Downloads/mothur/Esophagus/esophagus.tree"
# # # Actual examples follow:
# show_mothur_cutoffs(mothur_list_file)
# test1 <- import_mothur(mothur_list_file, mothur_group_file, mothur_tree_file)
# test2 <- import_mothur(mothur_list_file, mothur_group_file, mothur_tree_file, cutoff="0.02")
# # Returns just a tree
# import_mothur(mothur_list_file, mothur_tree_file=mothur_tree_file)
# # Returns just an otu_table
# import_mothur(mothur_list_file, mothur_group_file=mothur_group_file)
# # Returns an error
# import_mothur(mothur_list_file)
# # Should return an "OMG, you must provide the list file" error
# import_mothur()
}
\references{
\url{http://www.mothur.org/wiki/Main_Page}

Schloss, P.D., et al., Introducing mothur: Open-source, platform-independent,
community-supported software for describing and comparing microbial communities.
Appl Environ Microbiol, 2009. 75(23):7537-41.
}

