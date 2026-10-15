-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_album_asset_map labsm_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labsm_album_asset_map labsm_album_asset_map_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_album_asset_map
    ADD CONSTRAINT labsm_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
