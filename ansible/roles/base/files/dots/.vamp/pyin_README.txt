
pYIN
====

pYIN is a modification of the well-loved YIN algorithm for fundamental
frequency (F0) estimation in monophonic audio.

This is a Vamp plugin (https://vamp-plugins.org) implementation of
pYIN, as well as the original YIN method. The plugin can be used by
any Vamp host such as Sonic Visualiser and Sonic Annotator.


Method
======

The pYIN method is a modification of the method known as YIN (De
Cheveigné, Alain, and Hideki Kawahara. "YIN, a fundamental frequency
estimator for speech and music." The Journal of the Acoustical Society
of America 111 (2002)).

The original YIN has one threshold parameter. In pYIN this parameter
is replaced by a parameter distribution, and for every frame several
fundamental frequency candidates obtained, conditional on this prior
parameter distribution. In the second phase, a hidden Markov model
(HMM) is Viterbi-decoded to find a "smooth" path through the
fundamental frequency candidates. Note that this smoothed path is not
smudging or averaging pitch estimates: any pitch estimate contains
only fundamental frequency estimates that are genuine estimates of the
original YIN method for some threshold parameter.

The note estimator is a post-processing step on the pYIN pitch track,
also performed as Viterbi decoding of an HMM.


Limitations
===========

The pYIN method is designed to reliably extract the fundamental
frequency of audio recordings of a monophonic, harmonic instrument
such as the human voice. Being based on YIN means that pYIN exploits
the periodicity of the signal. In some circumstances it will not be
reliable. Such circumstances occur, e.g.

    ... if the source audio is not monophonic, e.g. a singer with
    accompanying instruments,

    ... if the recording has reverb/echo (this essentially makes it
    polyphonic),

    ... if, in a stringed instrument such as the cello, one string
    keeps ringing while the melody turns to a different pitch.


Authors, Citation, License and Use
==================================

pYIN was written by Matthias Mauch. Copyright 2012-2020 Matthias Mauch
and Queen Mary, University of London.

The YIN code was drawn from the Java implementation in the TarsosDSP
library by Joren Six.

If you make use of this software for any public or commercial purpose,
we ask you to kindly mention the authors and Queen Mary, University of
London in your user-visible documentation. We're very happy to see
this sort of use but would much appreciate being credited, separately
from the requirements of the software license itself (see below).

If you make use of this software for academic purposes, please cite
one of the publications indicated on the Publications page:

https://code.soundsoftware.ac.uk/publications?project_id=pyin

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A ARTICULAR PURPOSE. See the GNU
General Public License for more details. You should have received a
copy of the GNU General Public License along with this program. If
not, see http://www.gnu.org/licenses/.

