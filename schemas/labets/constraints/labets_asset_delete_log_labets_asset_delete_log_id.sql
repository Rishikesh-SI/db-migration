-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_asset_delete_log labets_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labets_asset_delete_log labets_asset_delete_log_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_asset_delete_log
    ADD CONSTRAINT labets_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
