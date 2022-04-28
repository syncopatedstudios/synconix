# Synconix
syn con ix
sync onix
synco nix

For detailed information, see documenation

# distro faith
The idea is to have the features of something like AVLinux/KxStudio/UbuntuStudio, yet not depend on any particular linux distro...as really, when not looking at eh configurations, it all sounds the same...after testing with many distros, none of them stood over another in terms of performance. This all starts with a minimal install anyway and Ansible does the configuration and the main part of the installation.

Several months ago I was more patient and was able to have ansible handle Fedora/Debian or Arch. After a while though, the work became
a bit much for what started out as a personal project...I ended up using Arch full-time as I just found it a bit easier to configure and Arch has pretty damned good documenation.
So currently, this works with Arch only, however the structure is still there if someone wanted to use this with a different distro. In the main vars area, the package names for Fedora and Debian are mostly there. When running the main playbook, ansible will determine what version of nix is being used and load a variables file named after the ditro. From there the distro and package_manager roles are called to deal with the indinviyual partiuclars of each distro.

# networked audio

Another reason for using ansible is the ability to configure multiple hosts that will connect with JackTrip | OSC | qmidinet

# backups and file syncing

osync

# Ansible and the learning curve

One advantage of taking the time to store the configurations in the ansible scheme is that one can certainly learn a lot about linux, which I feel is important in terms of maintainence and stability.

# software

zita-lrx for a 3-4 band xover
swh plugins

reaper

atom
sonic-pi

helm

ray-session


# sample | sound manangement

deadbeef....
sononym...

# workspace flow

With a keybaord driven interface, *(which can still utilize the mouse as you would be familar with),
one can find it easier to navigate|manage all of the running applications involved...
