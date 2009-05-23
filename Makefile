include common.mk

default:
	xcodebuild -target ukrun -buildstyle Development
	
all:
	xcodebuild -target All -buildstyle Development

test: default
	$(PBXBUILDDIR)/ukrun $(PBXBUILDDIR)/UnitKitTests.bundle

clean:
	 xcodebuild -alltargets clean
	 
site:
	$(MAKE) -w -C WebSite/

dist:
	makedist

install: install-root

install-root:
	sudo xcodebuild -alltargets clean
	sudo xcodebuild -target ukrun -buildstyle Deployment DSTROOT=/ install
	sudo xcodebuild -alltargets clean

install-user:
	xcodebuild -target ukrun_private -buildstyle Deployment
	ditto $(PBXBUILDDIR)/UnitKit.framework ~/Library/Frameworks/UnitKit.framework
	mkdir -p ~/bin
	ditto ukrun/ukrun ~/bin/ukrun
	ditto Xcode/File\ Templates ~/$(XCODEAPPSUPPORT)/File\ Templates/Cocoa/Objective-C\ UnitKit\ class.pbfiletemplate
	ditto Xcode/ObjCPlusPlus\ Templates ~/$(XCODEAPPSUPPORT)/File\ Templates/Cocoa/Objective-C++\ UnitKit\ class.pbfiletemplate
	ditto Xcode/Target\ Templates/UnitKit\ Bundle.trgttmpl ~/$(XCODEAPPSUPPORT)/Target\ Templates/Cocoa/UnitKit\ Bundle.trgttmpl
	
uninstall: uninstall-root uninstall-user

uninstall-root:
	sudo rm -rf /usr/local/bin/ukrun
	sudo rm -rf /Library/Frameworks/UnitKit.framework
	sudo rm -rf /$(XCODEAPPSUPPORT)/File\ Templates/Cocoa/Objective-C\ UnitKit\ class.pbfiletemplate
	sudo rm -rf /$(XCODEAPPSUPPORT)/File\ Templates/Cocoa/Objective-C++\ UnitKit\ class.pbfiletemplate
	sudo rm -rf /$(XCODEAPPSUPPORT)/Target\ Templates/Cocoa/UnitKit\ Bundle.trgttmpl

uninstall-user:
	rm -rf ~/bin/ukrun
	rm -rf ~/Library/Frameworks/UnitKit.framework
	rm -rf ~/$(XCODEAPPSUPPORT)/File\ Templates/Cocoa/Objective-C\ UnitKit\ class.pbfiletemplate
	rm -rf ~/$(XCODEAPPSUPPORT)/File\ Templates/Cocoa/Objective-C++\ UnitKit\ class.pbfiletemplate
	rm ~/$(XCODEAPPSUPPORT)/Target\ Templates/Cocoa/UnitKit\ Bundle.trgttmpl
	