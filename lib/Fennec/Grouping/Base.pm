package Fennec::Grouping::Base;
use strict;
use warnings;

use Carp;
our @CARP_NOT = ( __PACKAGE__, qw/Fennec::Grouping Fennec Fennec::Plugin/ );
use Scalar::Util qw/blessed/;
use Sub::Information as => 'inspect';

sub new {
    my $class = shift;
    my ( $name, %proto ) = @_;

    if ( $class->needs_method ) {
        my $info;
        my $method = $proto{method};
        my $ref = ref( $method ) ? $method
                                 : $proto{test}->can( $method );

        croak(
            $method ? "$method is not a valid method for $class"
                    : "No method provided"
        ) unless $ref;

        $info = inspect( $ref );
    }

    return bless(
        {
            filename => $info ? $info->file : undef,
            line => $info ? $info->line : undef,
            %proto,
            name => $name,
        },
        $class
    );
}

sub type { 'Base' }

sub needs_method { 1 }

sub partition {
    my $self = shift;
    my $data = $self->{ partition };
    return [ "" ] unless $data;
    return [ $data ] unless ref $data eq 'ARRAY';
    return $data;
}

sub todo {
    my $self = shift;
    return $self->{ todo };
}

sub test {
    my $self = shift;
    return $self->{ test };
}

sub filename {
    my $self = shift;
    return $self->{ filename };
}

sub line {
    my $self = shift;
    return $self->{ line };
}

sub name {
    my $self = shift;
    return $self->{ name };
}

sub method {
    my $self = shift;
    return $self->{ method };
}

sub run {
    my $self = shift;
    my $method = $self->method;
    $self->test->$method();
}

1;

=pod

=head1 NAME

Fennec::Grouping::Base - Base class for grouping classes

=head1 DESCRIPTION

Sets and Cases use this as a base class.

=head1 EARLY VERSION WARNING

This is VERY early version. Fennec does not run yet.

Please go to L<http://github.com/exodist/Fennec> to see the latest and
greatest.

=head1 METHODS

=over 4

=item $class->new( $name, %proto )

Create a new instance

=item $name = $obj->name()

Returns the name of the object

=item $method = $obj->method()

Returns the method associated with the object. Can be a coderef or method name.

=item $type = $obj->type()

Get the type of object. Subclasses should override this.

=item $obj->run()

Run the object method.

=back

=head1 AUTHORS

Chad Granum L<exodist7@gmail.com>

=head1 COPYRIGHT

Copyright (C) 2010 Chad Granum

Fennec is free software; Standard perl licence.

Fennec is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the license for more details.
