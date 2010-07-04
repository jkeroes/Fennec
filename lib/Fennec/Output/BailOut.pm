package Fennec::Output::BailOut;
use strict;
use warnings;

use base 'Fennec::Output';

sub new {
    my $class = shift;
    return bless( { @_ }, $class );
}

1;
=head1 SYNOPSIS

=head1 METHODS

=head2 new

=head1 AUTHORS

Chad Granum L<exodist7@gmail.com>

=head1 COPYRIGHT

Copyright (C) 2010 Chad Granum

Fennec is free software; Standard perl licence.

Fennec is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the license for more details.
