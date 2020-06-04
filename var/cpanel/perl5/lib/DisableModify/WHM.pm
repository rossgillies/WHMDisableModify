#!/usr/bin/env perl

package DisableModify::WHM;
   
use strict;
use warnings;
     
use JSON;
   
sub describe {
    my $my_check = {
        'category' => 'Whostmgr',
        'event'    => 'Accounts::Modify',
        'stage'    => 'pre',
        'hook'     => 'DisableModify::WHM::check',
        'exectype' => 'module',
    };
  
    return [ $my_check ];
}
  
sub check {
    my ( $context, $data ) = @_;
  
    my $result  = 1;
    my $message = 'Reseller is not modifying their own account.';

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
    } else {
        $message = 'User is root.';
    }
    return $result, $message;
}
  
1;
