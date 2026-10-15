-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_album_asset_map labtcs_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labtcs_album_asset_map labtcs_album_asset_map_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_album_asset_map
    ADD CONSTRAINT labtcs_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
