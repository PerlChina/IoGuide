#!perl

use 5.014;

use File::Slurp qw(read_file write_file);

my $text = read_file 'IoGuide.pod';

$text =~ s/B<(\w+)>/*$1*/g;
$text =~ s/C<(\w+)>/**$1**/g;
$text =~ s/L<(\w+)>/***$1***/g;

write_file('IoGuide.markdown', $text)
