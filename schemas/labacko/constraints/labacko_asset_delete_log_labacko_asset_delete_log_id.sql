-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_asset_delete_log labacko_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labacko_asset_delete_log labacko_asset_delete_log_id; Type: CONSTRAINT; Schema: labacko; Owner: -
--

ALTER TABLE ONLY labacko.labacko_asset_delete_log
    ADD CONSTRAINT labacko_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
