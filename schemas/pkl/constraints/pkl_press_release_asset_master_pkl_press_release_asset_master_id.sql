-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_press_release_asset_master pkl_press_release_asset_master_id
-- Type: CONSTRAINT

-- Name: pkl_press_release_asset_master pkl_press_release_asset_master_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_press_release_asset_master
    ADD CONSTRAINT pkl_press_release_asset_master_id PRIMARY KEY (asset_id);


--
