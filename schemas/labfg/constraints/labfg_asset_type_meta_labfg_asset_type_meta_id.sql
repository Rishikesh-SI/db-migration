-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_asset_type_meta labfg_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labfg_asset_type_meta labfg_asset_type_meta_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_asset_type_meta
    ADD CONSTRAINT labfg_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
