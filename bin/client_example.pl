#! /usr/bin/env perl

use v5.16;

use Getopt::Long qw(GetOptions);
use Slack::Client;

my $auth_token = $ENV{SLACK_AUTH_TOKEN};

GetOptions(
    "auth-token=s" => \$auth_token,
    "channel=s" => \(my $channel),
    "username=s" => \(my $username),
);

my $text = join " ", @ARGV;

if ($text && $channel && $username) {
    Slack::Client->new(auth_token => $auth_token)->post_message(
	channel => $channel,
	text => $text,
	username => $username,
    );
}
