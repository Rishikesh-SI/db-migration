-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_album_asset_map mum_album_asset_map_id
-- Type: CONSTRAINT

-- Name: tmm_album_asset_map mum_album_asset_map_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_album_asset_map
    ADD CONSTRAINT mum_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
