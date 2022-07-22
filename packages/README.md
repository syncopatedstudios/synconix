# packages

development|staging --> production

The goal is to have packages tested on a dev host, which after success, is then installed on a production host.

This system is designed to do both studio work and be used in a live setting. Packages and configurations for a live setting need to be stable and ideally replicable when performing studio work.

{--# fpm
Packages are built using fpm. This enables the system to be installed on a variety of distros. While a live-usb/installer can be used to install fresh system, it is based on arch. So if you are more comfortable with Debian|Ubuntu, or Fedora, then you should use the ansible based installer. --}
