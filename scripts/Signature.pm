#!/usr/bin/perl -wT

use strict;

package Signature;

use Digest::MD5 qw(md5_hex);

sub new {
    my $class = shift;
    my $self = {};
    $self->{shared_secret} = shift;
    return bless($self, $class);
}

sub sign {
    my $self = shift;
    my $data = shift;

    my $hash = md5_hex(md5_hex($data . $self->{shared_secret}) . $self->{shared_secret});

    return $hash;
}

sub unmodified {
    my $self = shift;
    my $data = shift;
    my $hash = shift;

    return $self->sign($data) eq $hash;
}

1;
