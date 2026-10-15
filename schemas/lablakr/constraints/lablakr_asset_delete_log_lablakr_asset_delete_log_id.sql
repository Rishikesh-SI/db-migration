-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_asset_delete_log lablakr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: lablakr_asset_delete_log lablakr_asset_delete_log_id; Type: CONSTRAINT; Schema: lablakr; Owner: -
--

ALTER TABLE ONLY lablakr.lablakr_asset_delete_log
    ADD CONSTRAINT lablakr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
