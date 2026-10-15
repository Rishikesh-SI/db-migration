-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_asset_group pcm_asset_group_id
-- Type: CONSTRAINT

-- Name: pcm_asset_group pcm_asset_group_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_asset_group
    ADD CONSTRAINT pcm_asset_group_id PRIMARY KEY (asset_group_id);


--
