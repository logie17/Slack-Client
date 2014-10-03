package Slack::Client;
use Moo;
use Mojo::UserAgent;

our $VERSION = 0.001;

has auth_token => (is => 'rw', required => 1);
has agent => (is => 'rw', lazy => 1, builder => '_build_agent');
has base_url => (is => 'ro', required => 1, default => sub { 'https://slack.com' });

sub _build_agent { 
    my $self = shift;
    my $agent = Mojo::UserAgent->new;
    $agent->on(start => sub {
            my ($ua, $tx) = @_;
            $tx->req->headers->header('Authoriziation' => 'Bearer ' . $self->auth_token);
    });
    return $agent;
}

sub post_message {
    my ($self, %params) = @_;

    my $res = $self->agent->post(
        $self->base_url . '/api/chat.postMessage' =>
        form => {
            channel => '#' . $params{channel},
            text => $params{text},
            username => $params{username},
	    token => $self->auth_token,
        }
    );
}

1;
