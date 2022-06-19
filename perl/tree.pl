#!/usr/bin/perl

my @tree = ("---", "L");

opendir (DIR, $ARGV[0] ) or die "Couldn't open directory, $!";
while ($file = readdir DIR) {
    if( -d $file ){
        opendir (SUBDIR, $file) or warn "Couldn't open directory, $file $!";
            while ($subfile = readdir SUBDIR) {
                print "$tree[1] $subfile\n";
            }
    }
   print "$tree[1] $file\n";
}
closedir DIR;
