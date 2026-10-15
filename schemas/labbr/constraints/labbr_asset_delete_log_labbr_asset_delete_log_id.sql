-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_asset_delete_log labbr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labbr_asset_delete_log labbr_asset_delete_log_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_asset_delete_log
    ADD CONSTRAINT labbr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
