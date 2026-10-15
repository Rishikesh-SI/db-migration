-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_poll_asset_map pcm_poll_asset_map_id
-- Type: CONSTRAINT

-- Name: pcm_poll_asset_map pcm_poll_asset_map_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_poll_asset_map
    ADD CONSTRAINT pcm_poll_asset_map_id PRIMARY KEY (poll_asset_map_id);


--
