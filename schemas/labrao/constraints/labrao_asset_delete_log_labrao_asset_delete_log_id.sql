-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_asset_delete_log labrao_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labrao_asset_delete_log labrao_asset_delete_log_id; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_asset_delete_log
    ADD CONSTRAINT labrao_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
