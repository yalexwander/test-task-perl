package Menu;
use strict;
use warnings;

use base qw( MenuStructureOperator );

sub new
{
    my $class = shift;

    my $self = {};
    bless $self, $class;

    $self->{menu} = [];

    return $self;
}


sub serialize {
    my $self = shift;
    my @serialized = ();

    foreach my $menu (@{$self->{'menu'}}) {
        push @serialized, $menu->serialize();
    }

    return \@serialized;
}

1;
