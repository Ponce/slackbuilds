#!/usr/bin/python3

import sys

import uharfbuzz as hb


fontfile = sys.argv[1]
text = sys.argv[2]

blob = hb.Blob.from_file_path(fontfile)
face = hb.Face(blob)
font = hb.Font(face)

buf = hb.Buffer()
buf.add_str(text)
buf.guess_segment_properties()

features = {"kern": True, "liga": True}
hb.shape(font, buf, features)

infos = buf.glyph_infos
positions = buf.glyph_positions

for info, pos in zip(infos, positions):
    gid = info.codepoint
    glyph_name = font.glyph_to_string(gid)
    cluster = info.cluster
    x_advance = pos.x_advance
    x_offset = pos.x_offset
    y_offset = pos.y_offset
    print(f"{glyph_name} gid{gid}={cluster}@{x_advance},{y_offset}+{x_advance}")
