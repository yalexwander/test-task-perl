package MenuManager;
use strict;
use warnings;

use Menu;
use MenuItem;
use SubmenuItem;
use Carp;

# here possible 2 ways to refactor. Split MenuManager into MenuMnagaer
# and SubmenuManager. This way is more correct from point of
# SOLID. Second way is to leave menu and submenu management inside one
# class. This way seems more correct for me.

# Not sure if using Carp module is a good idea here. Maybe returning
# errors is better way. But it is very common way to handle errors, so
# let's leave it.

sub new
{
    my $class = shift;
    my (%config) = @_;

    my $self = {};
    bless $self, $class;

    my $menu = shift;

    $self->{menu} = $menu || new Menu();

    return $self;
}


sub addMenuItemAfter
{
    my $self = shift;
    my ($anchor, $menuItem) = @_;

    my $addPos = $self->{'menu'}->getMenuPosition($anchor);

    if ($addPos == -1) {
        Carp::croak("Menu anchor not found");
    }

    $self->{'menu'}->addMenuItem($menuItem, $addPos + 1);

    return $self;
}


sub addMenuItemBefore
{
    my $self = shift;
    my ($anchor, $menuItem) = @_;

    my $addPos = $self->{'menu'}->getMenuPosition($anchor);

    if ($addPos == -1) {
        Carp::croak("Menu anchor not found");
    }

    $self->{'menu'}->addMenuItem($menuItem, $addPos);

    return $self;
}


sub addSubmenuItemBefore
{
    my $self = shift;
    my ($anchor, $subanchor, $newSubmenu) = @_;

    my $addPath = $self->_getSubmenuPath($anchor, $subanchor);
    $addPath->{'menu'}->addMenuItem($newSubmenu, $addPath->{'pos'});

    return $self;
}



sub addSubmenuItemAfter
{
    my $self = shift;
    my ($anchor, $subanchor, $newSubmenu) = @_;

    my $addPath = $self->_getSubmenuPath($anchor, $subanchor);
    $addPath->{'menu'}->addMenuItem($newSubmenu, $addPath->{'pos'} + 1);

    return $self;
}


sub _getSubmenuPath {
    my $self = shift;
    my ($anchor, $subanchor) = @_;

    my $menuAddPos = $self->{'menu'}->getMenuPosition($anchor);

    if ($menuAddPos == -1) {
        Carp::croak('Anchor not found');
    }

    my $menuItem = $self->{'menu'}->getMenuByPosition($menuAddPos);
    my $submenuAddPos = $menuItem->getMenuPosition($subanchor);

    if ($submenuAddPos == -1) {
        Carp::croak('Subanchor not found');
    }

    return {
        "menu" => $menuItem,
        "pos"  =>$submenuAddPos
    };
}


sub getMenu
{
    my $self = shift;

    return $self->{'menu'};

}

1;
