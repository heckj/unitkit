=======================
Building UnitKit 2
=======================

Using the Installer is the easiest way to set up UnitKit for use on a system. If you are working on UnitKit, however, or want to configure it for some specialized purpose, then building UnitKit from scratch is probably the right thing to do. The first thing to do is to get ahold of the source code. You can either download the source code archive **(not yet availalbe)** or you can check it out from its Subversion repository.

Checking Out the Source From Subversion
---------------------------------------

To do this, you'll need Subversion installed on your system. If you don't yet have Subversion set up, you'll need to get it from the `Subversion website`_. Once you are set up with Subversion, you can check out the UnitKit repository with the following command:

.. _Subversion website: http://tigris.subversion.org/

::

$ svn co https://svn.x180.net/public/unitkit/trunk [destination]

**Add instructions about tags and destinations and what not**

The Source Code Tree
--------------------

**Coming**

Performing a System Install
---------------------------

There are two ways that you can install UnitKit on your system from the source tree. The first is to use the ``xcodebuild`` command::

$ xcodebuild -buildstyle Deployment -target ukrun DSTROOT=/ install

All of UnitKit's components will be installed into the same location as the Installer package would place them.

The second way to install is to use the Makefile included with the UnitKit source tree::

$ make install

Installing with the makefile also takes care of cleaning up the build tree before and after.

Installing Into Your Home Directory
-----------------------------------

Some developers prefer installing UnitKit into their home directory rather than at the system root. To install UnitKit into your home directory, execute the following::

$ make install-user

This will install the UnitKit framework and Xcode integration files into your ``~/Library`` folder and the ``ukrun`` executable into ``~bin``.
