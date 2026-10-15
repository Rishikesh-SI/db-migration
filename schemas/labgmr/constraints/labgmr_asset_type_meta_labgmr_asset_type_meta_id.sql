-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_asset_type_meta labgmr_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labgmr_asset_type_meta labgmr_asset_type_meta_id; Type: CONSTRAINT; Schema: labgmr; Owner: -
--

ALTER TABLE ONLY labgmr.labgmr_asset_type_meta
    ADD CONSTRAINT labgmr_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
