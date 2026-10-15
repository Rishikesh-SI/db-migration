-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_album_asset_map labman_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labman_album_asset_map labman_album_asset_map_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_album_asset_map
    ADD CONSTRAINT labman_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
