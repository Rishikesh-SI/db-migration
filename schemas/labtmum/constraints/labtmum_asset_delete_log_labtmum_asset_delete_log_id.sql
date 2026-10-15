-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: labtmum_asset_delete_log labtmum_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labtmum_asset_delete_log labtmum_asset_delete_log_id; Type: CONSTRAINT; Schema: labtmum; Owner: -
--

ALTER TABLE ONLY labtmum.labtmum_asset_delete_log
    ADD CONSTRAINT labtmum_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
