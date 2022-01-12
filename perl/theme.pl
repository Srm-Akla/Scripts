#!/usr/bin/perl

use strict;
use warnings;

my $CONFIG=$ENV{'XDG_CONFIG_HOME'};
my $HOME=$ENV{'HOME'};
my $arg1=$ARGV[0] or die "No Arguments found!\n use '-h' for help \n";
my $flag; # 0 = light mode ; 1 = dark mode;

my %light= ( 
    "gtk"  =>  "Nordic-Polar",
    "bat" => "OneHalfLight",
    "fm" => "my-light",
    "term" => "day"
    );

my %dark= ( 
    "gtk"  =>  "Nordic-darker",
    "bat" => "OneHalfDark",
    "fm" => "palenight",
    "term" => "nord"
    );

my %files = ( 
    "gtk"  =>  "$CONFIG/gtk-3.0/settings.ini",
    "bat" => "$CONFIG/bat/config",
    "fm" => "$CONFIG/vifm/vifmrc",
    "launcher" => "$CONFIG/rofi/themes/my-slate.rasi",
    "powermenu" => "$CONFIG/rofi/themes/my-powermenu.rasi",
    "xresources" => "$HOME/.Xresources",
    "term" => "$CONFIG/alacritty/schemes.yml"
    );

sub write_flag{
    $flag = $_[0];
    open(FLAGS,">flags") or warn "Couldn't open file \n$!";
    print FLAGS $flag;
    close(FLAGS);

}

sub check_files{
    foreach my $a (keys %files){
        if(-f $files{$a}){
            warn("\e[1;32m Found: \e[00m $files{$a} \n");
        }else{
            warn("\e[1;32m Not Found: \e[00m $files{$a} \n");
        }
    }
}

sub light{
    print "Light Mode Set!\n";
    write_flag("1");
}
sub dark{
    print "Dark Mode Set!\n";
    write_flag("0");
}

sub help{
    
    print(" \e[1mOptions:\e[00m
    -l  --light     light-mode
    -d  --dark      dark-mode
    -c  --check     check-files
    \n");

}
sub main{
    if( $arg1 eq "-l" ) {
        light();
    } elsif( $arg1 eq "-d" ) {
        dark();
    } elsif( $arg1 eq "-h") {
        help();
    } elsif( $arg1 eq "-c") {
        check_files();
    }else{
        help();
    }
}

main();
