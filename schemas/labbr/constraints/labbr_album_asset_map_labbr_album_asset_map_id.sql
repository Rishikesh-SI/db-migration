-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_album_asset_map labbr_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labbr_album_asset_map labbr_album_asset_map_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_album_asset_map
    ADD CONSTRAINT labbr_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
