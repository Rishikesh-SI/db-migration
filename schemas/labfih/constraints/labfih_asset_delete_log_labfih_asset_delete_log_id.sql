-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_asset_delete_log labfih_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labfih_asset_delete_log labfih_asset_delete_log_id; Type: CONSTRAINT; Schema: labfih; Owner: -
--

ALTER TABLE ONLY labfih.labfih_asset_delete_log
    ADD CONSTRAINT labfih_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
