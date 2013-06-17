#!perl

use 5.014;

my $file = "IoGuide.md";

use File::Slurp qw(read_file write_file);

my @lines = read_file $file;

my @new_lines = ();
my $code_mode = 0;

foreach my $line (@lines) {
   chomp $line;
   if ($line eq '[') {
      $code_mode = 1;
      next;
   }
   if ($line eq ']') {
      $code_mode = 0;
      next;
   }

   if ($code_mode == 1) {
      push @new_lines, '    ' . $line;
   }
   else {
      push @new_lines, $line;
   }
}

@new_lines = map { $_ . chr(10) } @new_lines;

write_file('IoGuide.tod', [ @new_lines ]);


