-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_asset_delete_log labsrk_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labsrk_asset_delete_log labsrk_asset_delete_log_id; Type: CONSTRAINT; Schema: labsrk; Owner: -
--

ALTER TABLE ONLY labsrk.labsrk_asset_delete_log
    ADD CONSTRAINT labsrk_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
