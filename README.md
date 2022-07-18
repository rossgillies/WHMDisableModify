# Installation
To prevent resellers from modifying their primary account:
1. Upload WHM.pm to `/var/cpanel/perl5/lib/DisableModify/`
2. Run `/usr/local/cpanel/bin/manage_hooks add module DisableModify::WHM`

To prevent resellers from changing the Feature List assigned to packages:
1. Upload WHM.pm to `/var/cpanel/perl5/lib/DisableFeatureList/`
2. Run `/usr/local/cpanel/bin/manage_hooks add module DisableFeatureList::WHM`
