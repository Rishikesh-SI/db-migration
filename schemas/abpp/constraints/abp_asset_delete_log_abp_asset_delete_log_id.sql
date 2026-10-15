-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_asset_delete_log abp_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: abp_asset_delete_log abp_asset_delete_log_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_asset_delete_log
    ADD CONSTRAINT abp_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
