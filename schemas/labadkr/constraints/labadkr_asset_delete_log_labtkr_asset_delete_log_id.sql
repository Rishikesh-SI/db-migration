-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_asset_delete_log labtkr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labadkr_asset_delete_log labtkr_asset_delete_log_id; Type: CONSTRAINT; Schema: labadkr; Owner: -
--

ALTER TABLE ONLY labadkr.labadkr_asset_delete_log
    ADD CONSTRAINT labtkr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
