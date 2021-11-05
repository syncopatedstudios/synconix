#
warning: downgrading package harfbuzz (3.1.0-1 => 2.9.1-1)
warning: downgrading package harfbuzz-icu (3.1.0-1 => 2.9.1-1)
warning: downgrading package icu (69.1-1 => 64.2-1)
warning: downgrading package raptor (2.0.15-16 => 2.0.15-11)
resolving dependencies...
looking for conflicting packages...

Package (4)   Old Version  New Version  Net Change

harfbuzz      3.1.0-1      2.9.1-1       -0.13 MiB
harfbuzz-icu  3.1.0-1      2.9.1-1        0.00 MiB
icu           69.1-1       64.2-1        -1.44 MiB
raptor        2.0.15-16    2.0.15-11     -0.93 MiB
   35)  harfbuzz    2.9.1  1  remote
   35)  harfbuzz-icu    2.9.1  1  remote
    2)  icu    64.2  1  remote
   1)  raptor    2.0.15  11  remote




downgrade qt5-base qt5-declarative qt5-location qt5-multimedia qt5-script qt5-sensors qt5-svg qt5-tools qt5-webchannel qt5-webengine qt5-websockets qt5-x11extras qt5-xmlpatterns
+   34)  qt5-base    5.13.2           1  remote
+  16)  qt5-declarative    5.13.2          1  remote
+  16)  qt5-location    5.13.2       1  remote
+  14)  qt5-multimedia    5.13.2       1  remote

+  14)  qt5-script    5.13.2       1  remote

+  14)  qt5-sensors    5.13.2       1  remote

+  14)  qt5-svg    5.13.2          1  remote

+  21)  qt5-tools    5.13.2          1  remote

+  14)  qt5-webchannel    5.13.2       1  remote
+  26)  qt5-webengine    5.13.2       1  remote

+  14)  qt5-websockets    5.13.2       1  remote
+  14)  qt5-x11extras    5.13.2       1  remote
+  14)  qt5-xmlpatterns    5.13.2       1  remote




downgrade python-pyqt5 pyqt5-common python-sip-pyqt5

pyqt5-common    5.13.2  1  remote
python-pyqt5    5.13.2  1  remote
python-sip-pyqt5    4.19.14  1  remote

18)  qscintilla-qt5    2.11.6  2  remote



pip install PyQt5==5.13.2
pip install PyQt5-sip==12.7.0
