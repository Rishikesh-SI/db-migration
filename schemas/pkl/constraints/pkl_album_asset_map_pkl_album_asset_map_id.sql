-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_album_asset_map pkl_album_asset_map_id
-- Type: CONSTRAINT

-- Name: pkl_album_asset_map pkl_album_asset_map_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_album_asset_map
    ADD CONSTRAINT pkl_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
