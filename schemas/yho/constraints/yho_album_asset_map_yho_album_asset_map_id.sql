-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_album_asset_map yho_album_asset_map_id
-- Type: CONSTRAINT

-- Name: yho_album_asset_map yho_album_asset_map_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_album_asset_map
    ADD CONSTRAINT yho_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
