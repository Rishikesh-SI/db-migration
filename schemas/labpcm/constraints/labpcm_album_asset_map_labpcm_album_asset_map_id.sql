-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_album_asset_map labpcm_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labpcm_album_asset_map labpcm_album_asset_map_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_album_asset_map
    ADD CONSTRAINT labpcm_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
