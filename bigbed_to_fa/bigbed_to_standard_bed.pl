#!/usr/bin/perl
use warnings;
use strict;

=head1 NAME

bigbed_to_standard_bed.pl - Convert bigBed file to standard BED file

=head1 SYNOPSIS

bigbed_to_standard_bed.pl -i ${input}.bb > ${out.bed}

=head1 DESCRIPTION

This script converts a bigBed file to a BED file that contains only
the standard BED fields. This BED output file can then be used with
tools that do not support the bedPlus format.

=head1 OPTIONS

=over 4

=item -i,--infile <in.bb>

=back

=head1 VERSION

Last update: 2017-05-08

=cut


#====================
# Libraries
#====================
use Getopt::Long;
use Pod::Usage;
use Carp;

## no critic (ProhibitConstantPragma)
# Use constant instead of Readonly to avoid dependence on CPAN modules
use constant BIGBED_SUMMARY => "bigBedSummary";
use constant BIGBED_TO_BED => "bigBedToBed";
## use critic

#====================
# Main Program
#====================
sub main {
  my %params = parse_arguments();

  my $field_count = get_num_defined_fields($params{infile});

  bigbed_to_bed($params{infile}, $field_count);

  return;
}

main();


#====================
# Subroutines
#====================
sub bigbed_to_bed {
  my ($infile, $field_count) = @_;

  my @cmd_args = (BIGBED_TO_BED, $infile, "stdout");

  open(my $cmd_ph, "-|", @cmd_args) or
    croak("Cannot run bigBedToBed: $!");

  while (defined(my $line = <$cmd_ph>)) {
    chomp($line);

    my @fields = (split(/\t/x, $line));

    my $last_idx = $field_count - 1;

    print join("\t", @fields[0..$last_idx]), "\n";
  }

  close($cmd_ph) or croak("Cannot close input stream: $!");

  return;
}

sub get_num_defined_fields {
  my ($infile) = @_;

  my $num_fields = 3;

  my @cmd_args = (BIGBED_SUMMARY, "-fields", $infile);

  open(my $cmd_ph, "-|", @cmd_args) or
    croak("Cannot run bigBedSummary: $!");

  while (defined(my $line = <$cmd_ph>)) {
    chomp($line);

    if ($line =~ /(\d+)\s+bed\s+definition\s+fields/x) {
      $num_fields = $1;
      last;
    }
  }

  close($cmd_ph) or croak("Cannot close input stream: $!");

  return $num_fields;
}

#====================
# Parse command-line arguments
#====================
sub parse_arguments {
  my $infile   = undef;
  my $help = 0;

  GetOptions(
    'help|?'       => \$help,
    'infile|i=s'   => \$infile
  ) or usage();

  pod2usage( { verbose => 2 } ) if ($help);

  # check required arguments
  usage("Missing bigBed file") unless ( defined($infile) );

  return (
    infile => $infile,
  );
}

sub usage {
  my $msg = shift;

  pod2usage({ verbose => 1, message => $msg || "" });
  exit 1;
}
