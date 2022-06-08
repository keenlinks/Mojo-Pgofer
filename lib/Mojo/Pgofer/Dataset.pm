package Mojo::Pgofer::Dataset;

use Mojo::Base -base;
use Mojo::Loader qw(data_section);
use Mojo::Util qw(monkey_patch);

our $VERSION = '0.01_4';

has 'db';

sub AUTOLOAD {
  our $AUTOLOAD;
  my $self = shift;
  my ($class, $sub) = $self->_call($AUTOLOAD);
  my $sql = join ' ', split '\n', data_section $class, $sub;
  monkey_patch $class, $sub => sub {shift->db->query($sql, @_)};
  $self->$sub(@_);
}

sub _call {
  my $position = rindex $_[1], '::';
  return (substr($_[1], 0, $position), substr($_[1], $position + 2));
}

1;
__END__

=encoding utf-8

=head1 NAME

Mojo::Pgofer::Dataset - Interface to Mojo::Pg.

=head1 VERSION

0.01_4

=head1 SOURCE REPOSITORY

L<http://github.com/keenlinks/Mojo-Pgofer-Set>

=head1 AUTHOR

Scott Kiehn E<lt>sk.keenlinks@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2022 - Scott Kiehn

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
