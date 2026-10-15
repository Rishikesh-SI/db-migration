-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_asset_delete_log utt_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: utt_asset_delete_log utt_asset_delete_log_id; Type: CONSTRAINT; Schema: utt; Owner: -
--

ALTER TABLE ONLY utt.utt_asset_delete_log
    ADD CONSTRAINT utt_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
