-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_asset_delete_log pkl_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: pkl_asset_delete_log pkl_asset_delete_log_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_asset_delete_log
    ADD CONSTRAINT pkl_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
