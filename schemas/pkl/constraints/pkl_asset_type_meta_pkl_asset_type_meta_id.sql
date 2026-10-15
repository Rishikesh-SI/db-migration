-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_asset_type_meta pkl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: pkl_asset_type_meta pkl_asset_type_meta_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_asset_type_meta
    ADD CONSTRAINT pkl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
