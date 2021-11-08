package SubmenuItemTest;
use strict;
use warnings;
use base 'TestCase';

use SubmenuItem;

sub test_serialize
{
    my $self = shift;

    my $testSerialized = {
        'url' => 'abc',
        'title' => 'Submenu1'
    };

    my $submenu = new SubmenuItem(title => "Submenu1", url => 'abc');

    $self->assert_deep_equals(
        $testSerialized,
        $submenu->serialize()
    );
}

1;
