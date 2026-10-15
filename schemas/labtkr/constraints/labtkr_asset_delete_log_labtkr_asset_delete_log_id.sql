-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_asset_delete_log labtkr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labtkr_asset_delete_log labtkr_asset_delete_log_id; Type: CONSTRAINT; Schema: labtkr; Owner: -
--

ALTER TABLE ONLY labtkr.labtkr_asset_delete_log
    ADD CONSTRAINT labtkr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
