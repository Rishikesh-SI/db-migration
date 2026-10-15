-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_album_asset_map labets_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labets_album_asset_map labets_album_asset_map_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_album_asset_map
    ADD CONSTRAINT labets_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
