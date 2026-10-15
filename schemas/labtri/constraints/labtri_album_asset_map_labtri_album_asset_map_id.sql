-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_album_asset_map labtri_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labtri_album_asset_map labtri_album_asset_map_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_album_asset_map
    ADD CONSTRAINT labtri_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
