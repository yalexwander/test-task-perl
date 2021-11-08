package MenuItem;
use strict;
use warnings;

use base qw( MenuStructureOperator );

# While it is possible to have a MenuItem and SubmenuItem as one class
# with parent/children, to keep it SOLID, I've moved it to separate
# classes. Probably that's overkill.
use SubmenuItem;


sub new
{
    my $class = shift;

    my $self = {};
    bless $self, $class;

    my %args = @_;

    $self->{'title'} = $args{'title'};
    $self->{'menu'} = $args{'menu'} || [];

    return $self;
}


# can be moved to separate serialization component from one side, but
# from another one, keeping serialization method here will make class
# easier to test
sub serialize {
    my $self = shift;

    my @serialized_submenus = ();

    foreach my $submenu (@{ $self->{'menu'} }) {
        push @serialized_submenus, $submenu->serialize();
    }

    return {
        'title' => $self->{'title'},
        'menu' => \@serialized_submenus
    };
}

# We need some ID, for position inserts. Let's assume it will be same
# as title for now
sub getAnchor {
    my $self = shift;
    return $self->{'title'};
}

1;
