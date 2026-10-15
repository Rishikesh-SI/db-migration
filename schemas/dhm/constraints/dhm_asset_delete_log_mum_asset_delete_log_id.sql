-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_asset_delete_log mum_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: dhm_asset_delete_log mum_asset_delete_log_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_asset_delete_log
    ADD CONSTRAINT mum_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
