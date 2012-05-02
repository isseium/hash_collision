#!/usr/local/bin/perl

use warnings;
use strict;

use Digest::MD5 qw/md5_hex/;

my $hash;
my $i = 0;

while(1){
    my @arr_string; 
    my $ascii_code = $i;

    # int => ascii
    while($ascii_code != 0){
        unshift( @arr_string, $ascii_code % 128 );
        $ascii_code = int( $ascii_code / 128 );
    }
    my $string = join('', map{ chr $_} @arr_string);

    if($i % 10000000 == 0){
        print "${i}, lenght(${string}) = " . length($string) . "\n";
    }

    # Check
    my $md5 = md5_hex $string;
    if( exists $hash->{$md5} ){
        print "Collision: " . $hash->{$md5} . "," .  $string . "\n";
        last;
    }

    # ハッシュに格納
    $hash->{$md5} = $string;

    $i++;
}
