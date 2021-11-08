#!/usr/bin/perl
use Test::Unit::TestRunner;

foreach my $testClass (@ARGV) {
    my $testrunner = Test::Unit::TestRunner->new();
    $testrunner->start($testClass);
}
