-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_album_asset_map tsk_album_asset_map_id
-- Type: CONSTRAINT

-- Name: tsk_album_asset_map tsk_album_asset_map_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_album_asset_map
    ADD CONSTRAINT tsk_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
