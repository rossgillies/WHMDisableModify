#!/usr/bin/env perl
package DisableFeatureList::WHM;

use strict;
use warnings;
use JSON;

sub describe {
    my $checkPackage = {
        'category' => 'Whostmgr',
        'event'    => 'Packages::verify_input_data',
        'stage'    => 'pre',
        'hook'     => 'DisableFeatureList::WHM::check',
        'exectype' => 'module',
    };

    return [ $checkPackage ];
}

sub check {
    my ( $context, $data ) = @_;
    my $result = 1;
    my $message = 'User is root.';
    if ($ENV{'REMOTE_USER'} ne 'root') {
        if ($data->{'featurelist'} !~ /^(default|Mail Only)$/) {
            $message = 'Feature list must be "default" or "Mail Only".';
            $result = 0
        }
    }

    return $result, $message;
}

1;