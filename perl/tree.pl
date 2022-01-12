#!/usr/bin/perl

opendir (DIR, $ARGV[0] ) or die "Couldn't open directory, $!";
while ($file = readdir DIR) {
   print "$file\n";
}
closedir DIR;
