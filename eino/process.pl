#!/usr/bin/env perl

## run as ./process.pl <path> <caption>
## if caption not specified, uses 'a bird'
## generates thumbnails if they don't exists
## expects to find base images along with @2x and @3x.

use strict;
use 5.010;
use Data::Dumper qw(Dumper);

my $wdir = shift @ARGV;
my $caption = $ARGV[0] // 'a bird';
my %entries = ();
my @names = ();
opendir my $dh, $wdir or die "not a directory";
while (my $fname = readdir $dh) {
	if ($fname =~ /^\./) { next; }
	if ($fname =~ /@/) { next; }
	if ($fname =~ /\-thumb/) { next }
	if ($fname !~ /\.jpg$/) { next; }
	$fname =~ s/\.jpg$//;
	push @names, $fname;
	$entries{$fname} = 1;
}
closedir $dh;
# case-insensetive sort
@names = sort { "\L$a" cmp "\L$b" } keys %entries;

print qq(
<div class="eino-thumbs" style="border: 1 solid black">
);

my %seen = ();
foreach my $fname (@names) {
	if ($seen{$fname}) { next; }
	$seen{$fname} = 1;
	my $tname = "$wdir/$fname.jpg";
	$tname =~ s#\.jpg#-thumb.jpg#;
	# create thumbnails if they don't exist
	unless (-e $tname) {
		print STDERR "generating thumbnail $tname\n";
		system("/usr/local/bin/convert -thumbnail 200 $wdir/$fname.jpg $tname");
	}
print qq(
	<a class="eino-photo" href="$fname.jpg" title="$caption"
	data-srcset="$fname.jpg 1x, $fname\@2x.jpg 2x, $fname\@3x 3x">
		<img src="$fname-thumb.jpg">
	</a>
);
}

print qq(
</div>

<script type="text/javascript">
\$(document).ready(function() {
	const elems = document.querySelectorAll('.eino-photo');
	const myLb = Chocolat(elems, {});
});
</script>
);
