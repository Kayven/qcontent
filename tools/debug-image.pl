#!/usr/bin/env perl

use strict;
use warnings;
#use Smart::Comments;

use Getopt::Long;
use TokyoTyrant;
use Digest::MD5 qw(md5 md5_hex);

my $host = "localhost";
my $port = 9880;

GetOptions("host=s"  => \$host,
           "port=i" => \$port,
        );

my $key = shift or
    die "no key gived!";
if ($key =~ /^http/) {
    $key = md5_hex($key);
}

# create the object
my $rdb = TokyoTyrant::RDB->new();

# connect to the server
if(!$rdb->open($host, $port)){
    my $ecode = $rdb->ecode();
    printf STDERR ("open error: %s\n", $rdb->errmsg($ecode));
}

my $image = $rdb->get("$key.i");
print $image;
#print length($image) . "\n";
### $vdom

# close the connection
if( !$rdb->close() ) {
    my $ecode = $rdb->ecode();
    printf STDERR ("close error: %s\n", $rdb->errmsg($ecode));
}
