package Mojo::Pgofer;

use Mojo::Base -base;
use Mojo::Loader qw(find_modules load_class);
use Mojo::Pg;

our $VERSION = '0.01_5';

has 'connection';
has 'classname';
has pg => sub {Mojo::Pg->new($_[0]->connection)};

sub load {
  my $pg = $_[0]->pg;
  for my $module (find_modules $_[0]->classname) {
    load_class $module;
    my $attr = _attr($module);
    $_[0]->attr($attr => sub {$module->new(pg => $pg)});
  }
}

sub _attr {lc substr $_[0], (rindex $_[0], '::') + 2}

1;
__END__

=encoding utf-8

=head1 NAME

Mojo::Pgofer - Interface to Mojo::Pg.

=head1 VERSION

0.01_5

=head1 SOURCE REPOSITORY

L<http://github.com/keenlinks/Mojo-Pgofer>

=head1 AUTHOR

Scott Kiehn E<lt>sk.keenlinks@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2022 - Scott Kiehn

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
