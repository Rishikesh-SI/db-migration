-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_album_asset_map labpr_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labpr_album_asset_map labpr_album_asset_map_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_album_asset_map
    ADD CONSTRAINT labpr_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
