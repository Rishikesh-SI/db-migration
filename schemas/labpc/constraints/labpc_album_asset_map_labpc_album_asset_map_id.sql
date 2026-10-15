-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_album_asset_map labpc_album_asset_map_id
-- Type: CONSTRAINT

-- Name: labpc_album_asset_map labpc_album_asset_map_id; Type: CONSTRAINT; Schema: labpc; Owner: -
--

ALTER TABLE ONLY labpc.labpc_album_asset_map
    ADD CONSTRAINT labpc_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
