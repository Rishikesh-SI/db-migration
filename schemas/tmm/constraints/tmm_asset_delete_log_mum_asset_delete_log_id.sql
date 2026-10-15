-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_asset_delete_log mum_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: tmm_asset_delete_log mum_asset_delete_log_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_asset_delete_log
    ADD CONSTRAINT mum_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
