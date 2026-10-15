-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_asset_delete_log pcm_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: pcm_asset_delete_log pcm_asset_delete_log_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_asset_delete_log
    ADD CONSTRAINT pcm_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
