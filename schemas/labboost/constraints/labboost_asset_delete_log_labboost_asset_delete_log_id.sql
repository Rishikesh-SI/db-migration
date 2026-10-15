-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_asset_delete_log labboost_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labboost_asset_delete_log labboost_asset_delete_log_id; Type: CONSTRAINT; Schema: labboost; Owner: -
--

ALTER TABLE ONLY labboost.labboost_asset_delete_log
    ADD CONSTRAINT labboost_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
