-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_asset_delete_log labrr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labrr_asset_delete_log labrr_asset_delete_log_id; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_asset_delete_log
    ADD CONSTRAINT labrr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
