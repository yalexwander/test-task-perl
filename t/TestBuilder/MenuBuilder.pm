package TestBuilder::MenuBuilder;
use strict;
use warnings;

use base 'Exporter';

our @EXPORT = qw( buildMenu );


sub buildMenu {

    my $menu = new Menu();

    $menu->addMenuItem(
        new MenuItem(
            title => "My menu",
            menu => [
                new SubmenuItem(title => "Submenu1", url => 'abc1' ),
                new SubmenuItem(title => "Submenu3", url => 'abc3' ),
                new SubmenuItem(title => "Submenu2", url => 'abc2' )
            ]
        ),
        0
    );

    $menu->addMenuItem(
        new MenuItem(
            title => "My menu 2",
            menu => [
                new SubmenuItem(title => "2 Submenu1", url => 'abc1' ),
                new SubmenuItem(title => "2 Submenu3", url => 'abc3' ),
                new SubmenuItem(title => "2 Submenu2", url => 'abc2' )
            ]
        ),
        1
    );

    $menu->addMenuItem(
        new MenuItem(
            title => "My menu 3",
            menu => [
                new SubmenuItem(title => "3 Submenu1", url => 'abc1' ),
                new SubmenuItem(title => "3 Submenu3", url => 'abc3' ),
                new SubmenuItem(title => "3 Submenu2", url => 'abc2' )
            ]
        ),
        2
    );


    return $menu;
};



1;
