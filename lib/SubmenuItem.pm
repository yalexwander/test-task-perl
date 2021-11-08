package SubmenuItem;
use strict;
use warnings;

# see MenuItem.pm if you think this class written strange

sub new
{
    my $class = shift;

    my $self = {};
    bless $self, $class;

    my %args = @_;

    $self->{'title'} = $args{'title'};
    $self->{'url'} = $args{'url'};

    return $self;
}

sub serialize {
    my $self = shift;

    return {
        'title' => $self->{'title'},
        'url' => $self->{'url'}
    };
}

sub getAnchor {
    my $self = shift;
    return $self->{'title'};
}


1;
