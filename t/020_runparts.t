#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use English qw( -no_match_vars );

use Test::More;
use File::Basename;
my $topdir      = $ENV{TOPDIR} || (dirname($0) . '/..');
my $testdatadir = "$topdir/t/testdata";

require_ok( "$topdir/aptitude-robot" );

my $aptitude_command;

$aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/empty-config"
);
is_deeply( [ $aptitude_command->pkglist_files() ], [],
    'empty config dir should result in empty file list' );

$aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/single-file"
);
is_deeply(
    [ $aptitude_command->pkglist_files() ],
    [ "$testdatadir/single-file/pkglist.d/10_foo" ],
    'single file case',
);

$aptitude_command = Aptitude::Robot::Command->new(
    config_dir => "$testdatadir/multiple-files"
);
is_deeply(
    [ $aptitude_command->pkglist_files() ],
    [
        "$testdatadir/multiple-files/pkglist.d/10_foo",
        "$testdatadir/multiple-files/pkglist.d/20_bar",
    ],
    'multiple file case',
);
done_testing();