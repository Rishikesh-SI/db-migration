-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_asset_delete_log labgsoc_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labgsoc_asset_delete_log labgsoc_asset_delete_log_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_asset_delete_log
    ADD CONSTRAINT labgsoc_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
