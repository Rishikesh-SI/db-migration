-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_asset_group pkl_asset_group_id
-- Type: CONSTRAINT

-- Name: pkl_asset_group pkl_asset_group_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_asset_group
    ADD CONSTRAINT pkl_asset_group_id PRIMARY KEY (asset_group_id);


--
