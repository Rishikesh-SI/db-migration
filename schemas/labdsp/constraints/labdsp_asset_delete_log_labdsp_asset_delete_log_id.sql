-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_asset_delete_log labdsp_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labdsp_asset_delete_log labdsp_asset_delete_log_id; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_asset_delete_log
    ADD CONSTRAINT labdsp_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
