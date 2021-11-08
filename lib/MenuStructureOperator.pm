package MenuStructureOperator;
use strict;
use warnings;

# this is abstract partial class for commom methods needed in Menu and MenuItem

sub getMenuPosition {
    my $self = shift;
    my $menuAnchor = shift;

    my $pos = 0;
    foreach my $existingMenu (@{ $self->{'menu'} }) {
        if ($menuAnchor eq $existingMenu->getAnchor()) {
            return $pos;
        }
        $pos++;
    }

    return -1;
}

sub getMenuByPosition {
    my $self = shift;
    my $pos = shift;

    if ($pos >= 0 and ($pos < $self->{'menu'})) {
        return $self->{'menu'}->[$pos];
    }

    Carp::croak('Trying to get non-exsisting menu');
}


# there is no check for adding out of boundaries. Just add to nearest
# border of menu
sub addMenuItem
{
    my $self = shift;
    my ($menu, $position) = @_;

    # we just create new menu or adding new one at the end
    if (($self->{'menu'} == 0) || ($self->{'menu'} <= $position) ) {
        push @{ $self->{'menu'} }, $menu;
    }
    # addin somewhere else
    else {
        splice @{$self->{'menu'}}, $position, 0, $menu;
    }
}


1;
