Disable resellers from modifying their account in WHM.

Prevents discrepancies with WHMCS.

# Installation
1. Upload WHM.pm to `/var/cpanel/perl5/lib/DisableModify/`
2. Run `/usr/local/cpanel/bin/manage_hooks add module DisableModify::WHM`
