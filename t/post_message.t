#! /usr/bin/env perl

use v5.16;
use Test::Most tests => 3;
use Test::Easy qw(resub);
use Test::Deep;

my $class = 'Slack::Client';

use_ok $class;

subtest "verify that we can post a message" => sub {
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

subtest "verify that we can modify our presence" => sub {
	my $rs = resub 'Mojo::UserAgent::post' => sub { };

	my $client = Slack::Client->new(auth_token => 'foo');
	
	$client->update_presence(presence => 'away');

	cmp_deeply($rs->method_args,[[
		'https://slack.com/api/presence.set',
		'form',
		{
		     presence => 'away',
		     token => 'foo',
		},
	]]);

        throws_ok { $client->update_presence(presence => 'invalid') } qr/invalid presence type/;
};
