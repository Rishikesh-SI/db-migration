-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_album_asset_map msl_album_asset_map_id
-- Type: CONSTRAINT

-- Name: msl_album_asset_map msl_album_asset_map_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_album_asset_map
    ADD CONSTRAINT msl_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
