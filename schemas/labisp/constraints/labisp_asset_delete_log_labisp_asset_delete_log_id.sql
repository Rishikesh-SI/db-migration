-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_asset_delete_log labisp_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labisp_asset_delete_log labisp_asset_delete_log_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_asset_delete_log
    ADD CONSTRAINT labisp_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
