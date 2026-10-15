-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_asset_delete_log labbg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labbg_asset_delete_log labbg_asset_delete_log_id; Type: CONSTRAINT; Schema: labbg; Owner: -
--

ALTER TABLE ONLY labbg.labbg_asset_delete_log
    ADD CONSTRAINT labbg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
