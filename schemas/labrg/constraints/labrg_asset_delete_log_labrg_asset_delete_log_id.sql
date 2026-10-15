-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_asset_delete_log labrg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labrg_asset_delete_log labrg_asset_delete_log_id; Type: CONSTRAINT; Schema: labrg; Owner: -
--

ALTER TABLE ONLY labrg.labrg_asset_delete_log
    ADD CONSTRAINT labrg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
