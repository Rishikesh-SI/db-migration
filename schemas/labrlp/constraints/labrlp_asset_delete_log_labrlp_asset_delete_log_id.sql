-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_asset_delete_log labrlp_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labrlp_asset_delete_log labrlp_asset_delete_log_id; Type: CONSTRAINT; Schema: labrlp; Owner: -
--

ALTER TABLE ONLY labrlp.labrlp_asset_delete_log
    ADD CONSTRAINT labrlp_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
