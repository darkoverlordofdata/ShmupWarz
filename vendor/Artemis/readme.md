# artemis

Clone of https://github.com/adamgit/ArtemisObjC

The 'standalone' version of CFBitVector is needed in FreeBSD, as there is no gnustep-corebase in the FreeBSD repo. Leaving this in is easier than porting the missing library.

Sone other changes for conditional compile - FreeBSD is on version GNUstep 2.0, while the Linux build stream create the 2.1 version og GNUstep.