#!/usr/bin/env perl
package DisableModify::WHM;

use strict;
use warnings;
use JSON;

sub describe {
    my $checkUser = {
        'category' => 'Whostmgr',
        'event'    => 'Accounts::Modify',
        'stage'    => 'pre',
        'hook'     => 'DisableModify::WHM::check',
        'exectype' => 'module',
    };
  
    return [ $checkUser ];
}

sub check {
    my ( $context, $data ) = @_;
    my $result  = 1;
    my $message = 'Not modifying own account.';
    my $cpuser = $data->{'user'};
    my $resellers = `cat /var/cpanel/resellers | cut -d: -f1`;
    my @resellers = split '\n', $resellers;
    if ($ENV{'REMOTE_USER'} ne 'root') {
        for my $reseller (@resellers) {
            if ($cpuser eq $reseller) {
                $message = 'Resellers are not allowed to modify their own account.';
                $result = 0
            }
        }
    }

    return $result, $message;
}

1;