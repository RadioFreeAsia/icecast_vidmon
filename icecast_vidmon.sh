#!/bin/sh

# icecast_vidmon.sh
#
# Send a WebM live stream to Icecast
#
#   (C) Copyright 2020 Fred Gleason <fredg@paravelsystems.com>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License version 2 as
#   published by the Free Software Foundation.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public
#   License along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#

. /etc/icecast_vidmon.conf

ffmpeg \
  -f decklink -i "$DECKLINK_NAME" \
  -vf "scale=$VIDEO_SIZE" \
  -f webm -cluster_size_limit 0 -cluster_time_limit 1100 -content_type video/webm \
  -c:a libvorbis -qscale:a 1 \
  -c:v libvpx -b:v $VIDEO_BITRATE -g $VIDEO_FRAMERATE -threads $VIDEO_THREADS \
  -ice_name "$ICECAST_STREAM_NAME" \
  -ice_description "$ICECAST_STREAM_DESCRIPTION" \
  -ice_genre "$ICECAST_STREAM_GENRE" \
  icecast://$ICECAST_USERNAME:$ICECAST_PASSWORD@$ICECAST_SERVER:$ICECAST_PORT$ICECAST_MOUNTPOINT

#
# Show Supported Formats
#
# ffmpeg -f decklink -list_formats 1 -i 'DeckLink Studio 4K'
