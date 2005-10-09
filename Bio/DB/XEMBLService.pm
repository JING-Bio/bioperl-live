#
# $Id$
#
# BioPerl module for Bio::DB::XEMBLService
#
# Cared for by Lincoln Stein <lstein@cshl.org>
#
# Copyright Lincoln Stein
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::DB::XEMBLService - SOAP service definition for XEMBL

=head1 SYNOPSIS

  #usage

=head1 DESCRIPTION

SOAP service definition for XEMBL.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                         - General discussion
  http://bio.perl.org/MailList.html             - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

  http://bugzilla.bioperl.org/

=head1 AUTHOR - Lincoln Stein

Email lstein@cshl.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut



package Bio::DB::XEMBLService;

# -- generated by SOAP::Lite (v0.51) for Perl -- soaplite.com -- Copyright (C) 2000-2001 Paul Kulchenko --
# -- generated from http://www.ebi.ac.uk/xembl/XEMBL.wsdl [Sat Jan 26 14:47:29 2002]

my %methods = (
  getNucSeq => {
    endpoint => 'http://www.ebi.ac.uk:80/cgi-bin/xembl/XEMBL-SOAP.pl',
    soapaction => 'http://www.ebi.ac.uk/XEMBL#getNucSeq',
    uri => 'http://www.ebi.ac.uk/XEMBL',
    parameters => [
      SOAP::Data->new(name => 'format', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'ids', type => 'xsd:string', attr => {}),
    ],
  },
);
use Bio::Root::Version;
use SOAP::Lite;
use Exporter;
use Carp ();

use vars qw(@ISA $AUTOLOAD @EXPORT_OK %EXPORT_TAGS);
@ISA = qw(Exporter SOAP::Lite);
@EXPORT_OK = (keys %methods);
%EXPORT_TAGS = ('all' => [@EXPORT_OK]);

no strict 'refs';
for my $method (@EXPORT_OK) {
  my %method = %{$methods{$method}};
  *$method = sub {
    my $self = UNIVERSAL::isa($_[0] => __PACKAGE__) 
      ? ref $_[0] ? shift # OBJECT
                  # CLASS, either get self or create new and assign to self
                  : (shift->self || __PACKAGE__->self(__PACKAGE__->new))
      # function call, either get self or create new and assign to self
      : (__PACKAGE__->self || __PACKAGE__->self(__PACKAGE__->new));
    $self->proxy($method{endpoint} || Carp::croak "No server address (proxy) specified") unless $self->proxy;
    my @templates = @{$method{parameters}};
    my $som = $self
      -> endpoint($method{endpoint})
      -> uri($method{uri})
      -> on_action(sub{qq!"$method{soapaction}"!})
      -> call($method => map {shift(@templates)->value($_)} @_); 
    UNIVERSAL::isa($som => 'SOAP::SOM') ? wantarray ? $som->paramsall : $som->result 
                                        : $som;
  }
}

1;
