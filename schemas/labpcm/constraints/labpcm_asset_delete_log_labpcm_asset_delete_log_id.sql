-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_asset_delete_log labpcm_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labpcm_asset_delete_log labpcm_asset_delete_log_id; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_asset_delete_log
    ADD CONSTRAINT labpcm_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
