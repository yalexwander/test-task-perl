package MenuTest;
use strict;
use warnings;
use base 'TestCase';

use TestBuilder::MenuBuilder;

use Menu;
use MenuItem;
use SubmenuItem;

sub test_getMenuPosition {
    my $self = shift;

    my $menu = TestBuilder::MenuBuilder::buildMenu();

    $self->assert_num_equals(0, $menu->getMenuPosition('My menu'));
    $self->assert_num_equals(1, $menu->getMenuPosition('My menu 2'));
    $self->assert_num_equals(2, $menu->getMenuPosition('My menu 3'));
}


sub test_addMenuItem {
    my $self = shift;

    my $menu = TestBuilder::MenuBuilder::buildMenu();

    $menu->addMenuItem(new MenuItem(title => "My menu middle"), 2);

    $self->assert_num_equals(2, $menu->getMenuPosition('My menu middle'));
    $self->assert_num_equals(3, $menu->getMenuPosition('My menu 3'));
}

1;
