#! /usr/bin/env perl

use v5.16;
use Test::Most tests => 2;
use Test::Easy qw(resub);
use Test::Deep;

my $class = 'Slack::Client';

use_ok $class;

subtest "verify that we can post a message" => sub {
	plan => 1;
	
	my $rs = resub 'Mojo::UserAgent::post' => sub { };

	my $client = Slack::Client->new(auth_token => 'foo');
	
	$client->post_message(channel => 'bar', text => 'one fine day', username => 'logiebear');

	cmp_deeply($rs->method_args,[[
		'https://slack.com/api/chat.postMessage',
		'form',
		{
		     channel => '#bar',
		     text => 'one fine day',
		     username => 'logiebear',
		     token => 'foo',
		},
	]]);
};
