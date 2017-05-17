# bedToBigBed


This is a Galaxy wrapper to convert a [BED](https://genome.ucsc.edu/FAQ/FAQformat.html#format1)
file into a [bigBed](https://genome.ucsc.edu/goldenpath/help/bigBed.html).

## Input files

### Chromosomes sizes file
This tool requires a chromosomes sizes (chrom.sizes) file, which lists the size of
each scaffold within an assembly. For genome assemblies that are hosted by UCSC,
the chrom.sizes file is available through the
[Sequence and Annotation Downloads](http://hgdownload.cse.ucsc.edu/downloads.html).
The [twoBitInfo](https://genome.ucsc.edu/goldenpath/help/twoBit.html) tool
can be used to generate the chrom.sizes for the genome assemblies that are not hosted
by UCSC.

### AutoSql files
The BED input file could contain extra fields (i.e. bedPlus). The definitions for the
fields in a bedPlus file can be specified using an
[AutoSql](http://genomewiki.ucsc.edu/index.php/AutoSql).

A large collection of AutoSql files are available through the
[UCSC Genome Browser source tree](https://github.com/ucscGenomeBrowser/kent/tree/master/src/hg/lib)
(files with the .as extension).

## Reference 

Kent, W. James and Sugnet, Charles W. and Furey, Terrence S. and Roskin, Krishna M. and Pringle, Tom H. and Zahler, Alan M. and Haussler, and David (2002). The Human Genome Browser at UCSC. In Genome Research, 12 (6), pp. 996-1006. [link](http://genome.cshlp.org/content/12/6/996.abstract)