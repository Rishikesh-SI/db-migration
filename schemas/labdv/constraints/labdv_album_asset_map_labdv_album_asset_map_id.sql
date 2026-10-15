-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_album_asset_map labdv_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labdv_album_asset_map labdv_album_asset_map_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_album_asset_map
    ADD CONSTRAINT labdv_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
