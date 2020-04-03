## Makefile
##
##   (C) Copyright 2020 Fred Gleason <fredg@paravelsystems.com>
##
##   This program is free software; you can redistribute it and/or modify
##   it under the terms of the GNU General Public License version 2 as
##   published by the Free Software Foundation.
##
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
##   You should have received a copy of the GNU General Public
##   License along with this program; if not, write to the Free Software
##   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
##

VERSION=`cat VERSION`

install:	
	mkdir -p $(DESTDIR)/usr/bin
	cp icecast_vidmon.sh $(DESTDIR)/usr/bin/icecast_vidmon.sh
	mkdir -p $(DESTDIR)/lib/systemd/system
	cp icecast_vidmon.service $(DESTDIR)/lib/systemd/system/icecast_vidmon.service
	./daemon-reload.sh

uninstall-local:	
	rm -f $(DESTDIR)/usr/bin/icecast_vidmon.sh
	rm -f $(DESTDIR)/lib/systemd/system/icecast_vidmon.service
	./daemon-reload.sh

dist:	
	./make_dist.sh

clean:	
	rm -f *~ *.rpm *.tar.gz

rpm:	dist
	mkdir -p $(HOME)/rpmbuild/SOURCES
	cp icecast_vidmon-$(VERSION).tar.gz $(HOME)/rpmbuild/SOURCES/
	rpmbuild -ba --target noarch-redhat-linux icecast_vidmon.spec
	mv $(HOME)/rpmbuild/RPMS/noarch/icecast_vidmon-*.rpm .
	mv $(HOME)/rpmbuild/SRPMS/icecast_vidmon-*.src.rpm .
	rm $(HOME)/rpmbuild/SOURCES/icecast_vidmon-$(VERSION).tar.gz
