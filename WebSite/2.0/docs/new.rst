=======================
New In UnitKit 2
=======================

UnitKit 2 marks a maturing of UnitKit. What started out as a young and scrappy framework is now starting to grow up into something a bit more, well, useful. As UnitKit has been used, and abused, we've had a chance to kick the tires and see what's really needed. And, we've even managed to implement some of those needed things.

UKEqual and UKNotEqual Test Macros
----------------------------------

Possibly the biggest change from a user perspective is the appearance of the Swiss-Army knife of test macros, ``UKEqual``, and its companion ``UKNotEqual``. Taking on the testing functionality of ``UKIntsEqual``, ``UKObjectsEqual``, and ``UKStringsEqual``, these new macros do even more. They can compare and determine equality for the following types:

- ``int`` and ``unsigned int``
- ``long`` and ``unsigned long``
- ``short`` and ``unsigned short``
- ``char`` and ``unsigned char``
- ``float``
- ``double``
- Any object, using the ``isEqual:`` method of ``NSObject``
- Any string of type ``NSString`` or its subclasses using the ``isEqualToString:`` method of ``NSString``
- Structs, including ``NSPoint`` and ``NSRange``
- Pointers
- Unions

All of the necessary type detection is performed under the covers. What this means is that you can use ``UKEqual`` for most of your test needs.

**Update with ``long long`` information once available.**

Growl Integration
-----------------

**more**

Internal Notification System
----------------------------

**more**

HTML Based Documentation
------------------------

**more**

Other New Features
------------------

- **list**
