package MenuItemTest;
use strict;
use warnings;
use base 'TestCase';

use MenuItem;
use SubmenuItem;


sub test_serialize
{
    my $self = shift;

    my $menu = new MenuItem(
        "title" => "My menu1",
        "menu" => [
            new SubmenuItem(
                title => "Submenu1",
                url => 'abc'
            )
        ]
    );

    my $serialized = $menu->serialize();

    my $testSerialized = {
        'title' => 'My menu1',
        'menu' => [
            {
                'url' => 'abc',
                'title' => 'Submenu1'
            }
        ]
    };

    $self->assert_deep_equals($serialized, $testSerialized);
}

1;
