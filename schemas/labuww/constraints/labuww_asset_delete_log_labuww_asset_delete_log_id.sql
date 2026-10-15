-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_asset_delete_log labuww_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labuww_asset_delete_log labuww_asset_delete_log_id; Type: CONSTRAINT; Schema: labuww; Owner: -
--

ALTER TABLE ONLY labuww.labuww_asset_delete_log
    ADD CONSTRAINT labuww_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
