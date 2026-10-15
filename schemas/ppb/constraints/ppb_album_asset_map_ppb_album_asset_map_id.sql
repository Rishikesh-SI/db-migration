-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_album_asset_map ppb_album_asset_map_id
-- Type: CONSTRAINT

-- Name: ppb_album_asset_map ppb_album_asset_map_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_album_asset_map
    ADD CONSTRAINT ppb_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
