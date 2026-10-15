-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_album_asset_map labgt_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labgt_album_asset_map labgt_album_asset_map_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_album_asset_map
    ADD CONSTRAINT labgt_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
