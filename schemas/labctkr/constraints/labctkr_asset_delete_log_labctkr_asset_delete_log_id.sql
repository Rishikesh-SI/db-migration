-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_asset_delete_log labctkr_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labctkr_asset_delete_log labctkr_asset_delete_log_id; Type: CONSTRAINT; Schema: labctkr; Owner: -
--

ALTER TABLE ONLY labctkr.labctkr_asset_delete_log
    ADD CONSTRAINT labctkr_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
