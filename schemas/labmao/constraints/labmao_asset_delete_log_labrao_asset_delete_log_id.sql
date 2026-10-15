-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_asset_delete_log labrao_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labmao_asset_delete_log labrao_asset_delete_log_id; Type: CONSTRAINT; Schema: labmao; Owner: -
--

ALTER TABLE ONLY labmao.labmao_asset_delete_log
    ADD CONSTRAINT labrao_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
