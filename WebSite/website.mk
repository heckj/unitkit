BUILDHTML=~/Code/Docutils/docutils/tools/rst2html.py

%.html: %.rst
	$(BUILDHTML) --stylesheet $(STYLESHEET) $< > $@
	cat $@ | sed -e 's/<\/body>/<div class="footer"><p>Copyright \&copy;2005 James Duncan Davidson and contributors.<br \/>The content of this website is licensed under a <a href="http:\/\/creativecommons.org\/licenses\/by-sa\/2.0\/">Creative Commons License<\/a><\/p><\/body>/' > $@