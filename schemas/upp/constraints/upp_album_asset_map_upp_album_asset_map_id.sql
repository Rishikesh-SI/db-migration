-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_album_asset_map upp_album_asset_map_id
-- Type: CONSTRAINT

-- Name: upp_album_asset_map upp_album_asset_map_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_album_asset_map
    ADD CONSTRAINT upp_album_asset_map_id PRIMARY KEY (album_asset_map_id);


--
