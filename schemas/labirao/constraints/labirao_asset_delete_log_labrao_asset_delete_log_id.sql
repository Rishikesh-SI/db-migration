-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_asset_delete_log labrao_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labirao_asset_delete_log labrao_asset_delete_log_id; Type: CONSTRAINT; Schema: labirao; Owner: -
--

ALTER TABLE ONLY labirao.labirao_asset_delete_log
    ADD CONSTRAINT labrao_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
