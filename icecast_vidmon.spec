Summary: Send a WebM live stream to Icecast
Name: icecast_vidmon
Version: 0.1.0
Release: 1%{?dist}
License: GPLv2
Source0: icecast_vidmon-%{version}.tar.gz
BuildRoot: /var/tmp/%{name}-%{version}
Requires: ffmpeg-icecast

%description
Send a WebM live stream to Icecast, using a BlackMagic DeckLink
capture card.

%prep

%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%post
if test ! -e /etc/icecast_vidmon.conf ; then
  cp %{_datadir}/doc/icecast_vidmon-%{version}/icecast_vidmon-sample.conf /etc/icecast_vidmon.conf
fi
/bin/systemctl daemon-reload

%preun
/bin/systemctl stop icecast_vidmon.service

%postun
/bin/systemctl daemon-reload

%files
%{_bindir}/icecast_vidmon.sh
/lib/systemd/system/icecast_vidmon.service
%doc ChangeLog
%doc COPYING
%doc icecast_vidmon-sample.conf
%doc README

%changelog
* Fri Apr  3 2020 Fred Gleason <fredg@paravelsystems.com> -
-- Initial RPM creation.
