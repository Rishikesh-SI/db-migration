-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_album_asset_map labrstg_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labrstg_album_asset_map labrstg_album_asset_map_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_album_asset_map
    ADD CONSTRAINT labrstg_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
