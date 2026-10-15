-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_asset_type_meta labjfc_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labjfc_asset_type_meta labjfc_asset_type_meta_id; Type: CONSTRAINT; Schema: labjfc; Owner: -
--

ALTER TABLE ONLY labjfc.labjfc_asset_type_meta
    ADD CONSTRAINT labjfc_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
