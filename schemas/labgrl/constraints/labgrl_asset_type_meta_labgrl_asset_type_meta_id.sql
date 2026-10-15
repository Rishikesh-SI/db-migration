-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_asset_type_meta labgrl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labgrl_asset_type_meta labgrl_asset_type_meta_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_asset_type_meta
    ADD CONSTRAINT labgrl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
