use strict;
use warnings;
package Slack::Client;
use Moo;
use Mojo::UserAgent;

our $VERSION = 0.001;

has api_key => (is => 'rw', required => 1);
has domain => (is => 'rw', required => 1);
has agent => (is => 'rw', lazy => 1);

sub _build_agent { 
    my $self = shift;
    my $agent = Mojo::UserAgent->new 
    $agent->on(start => sub {
            my ($ua, $tx) = @_;
            $tx->req->headers->header('Authoriziation' => 'Bearer ' . $self->api_key);
    });
}

sub post_message {
    my ($self) = @_;

    $self->agent->post(
        'https://slack.com/api/chat.postMessage' =>
        json => {
            channel => '#',
            text => "",
            username => "",
        };
    );
}

1;
