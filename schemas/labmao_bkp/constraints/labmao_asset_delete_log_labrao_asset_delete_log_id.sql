-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labmao_asset_delete_log labrao_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labmao_asset_delete_log labrao_asset_delete_log_id; Type: CONSTRAINT; Schema: labmao_bkp; Owner: -
--

ALTER TABLE ONLY labmao_bkp.labmao_asset_delete_log
    ADD CONSTRAINT labrao_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
