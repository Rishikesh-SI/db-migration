-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_album_asset_map hsl_album_asset_map_id
-- Type: CONSTRAINT

-- Name: hsl_album_asset_map hsl_album_asset_map_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_album_asset_map
    ADD CONSTRAINT hsl_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
