# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id: Domcut.t,v 1.1 2003/07/23 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'
use strict;
use vars qw($NUMTESTS $DEBUG $ERROR $METAERROR);
use lib '../';
$DEBUG = $ENV{'BIOPERLDEBUG'} || 0;
BEGIN {
    # to handle systems with no installed Test module
    # we include the t dir (where a copy of Test.pm is located)
    # as a fallback
    eval { require Test; };
    $ERROR = 0;
    if( $@ ) {
	use lib 't';
    }
    use Test;

    $NUMTESTS = 21;
    plan tests => $NUMTESTS;

    eval {
	require IO::String; 
	require LWP::UserAgent;
	
    }; 
    if( $@ ) {
        warn("IO::String or LWP::UserAgent not installed. This means that the module is not usable. Skipping tests");
	$ERROR = 1;
    }
	#check this is available, set error flag if not.
	eval {
		require Bio::Seq::Meta::Array;
		};
	if ($@) {
		warn ("Bio::Seq::Meta::Array not installed - will skip tests using meta sequences");
		$METAERROR = 1;
		}
}

END {
    foreach ( $Test::ntest..$NUMTESTS) {
	skip('unable to run all of the tests depending on web access',1);
    }
}

exit 0 if $ERROR ==  1;

use Data::Dumper;

use Bio::PrimarySeq;
require Bio::Tools::Analysis::Protein::Domcut;

ok 1;

my $verbose = 0;
$verbose = 1 if $DEBUG;

ok my $tool = Bio::WebAgent->new(-verbose =>$verbose);



my $seq = Bio::PrimarySeq->new(-seq => 'MSADQRWRQDSQDSFGDSFDGDPPPPPPPPFGDSFGDGFSDRSRQDQRS',
						-display_id => 'test2');

ok $tool = Bio::Tools::Analysis::Protein::Domcut->new( -seq=>$seq);
ok $tool->run ();
ok my $raw = $tool->result('');
ok my $parsed = $tool->result('parsed');
ok ($parsed->[23]{'score'}, '-0.209');
my @res = $tool->result('Bio::SeqFeatureI');
if (scalar @res > 0) {
    ok 1;
} else {
    skip('No network access - could not connect to NetPhos server', 1);
}
ok my $meta = $tool->result('all');

if (!$METAERROR) { #if Bio::Seq::Meta::Array available
	ok($meta->named_submeta_text('Domcut', 1,2), "0.068 0.053");
	ok ($meta->seq, "MSADQRWRQDSQDSFGDSFDGDPPPPPPPPFGDSFGDGFSDRSRQDQRS");
	}
ok my $tool2 = Bio::WebAgent->new(-verbose =>$verbose);



my $seq2 = Bio::PrimarySeq->new(-seq => 'MSADQRWRQDSQDSFGDSFDGDPPPPPPPPFGDSFGDGFSDRSRQDQRS',
						-display_id => 'test2');

ok $tool2 = Bio::Tools::Analysis::Protein::Domcut->new( -seq=>$seq2);
ok $tool2->run ();
ok my $raw2 = $tool2->result('');
ok my $parsed2 = $tool2->result('parsed');
ok ($parsed2->[23]{'score'}, '-0.209');
@res = $tool2->result('Bio::SeqFeatureI');
if (scalar @res > 0) {
    ok 1;
} else {
    skip('No network access - could not connect to NetPhos server', 1);
}
ok my $meta2 = $tool2->result('all');

if (!$METAERROR) { #if Bio::Seq::Meta::Array available
	ok($meta2->named_submeta_text('Domcut', 1,2), "0.068 0.053");
	ok ($meta2->seq, "MSADQRWRQDSQDSFGDSFDGDPPPPPPPPFGDSFGDGFSDRSRQDQRS");
	}
