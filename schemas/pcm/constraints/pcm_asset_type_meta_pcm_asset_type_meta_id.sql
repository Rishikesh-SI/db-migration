-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_asset_type_meta pcm_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: pcm_asset_type_meta pcm_asset_type_meta_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_asset_type_meta
    ADD CONSTRAINT pcm_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
