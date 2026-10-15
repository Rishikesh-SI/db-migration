-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_asset_type_meta jafc_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: jafc_asset_type_meta jafc_asset_type_meta_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_asset_type_meta
    ADD CONSTRAINT jafc_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
