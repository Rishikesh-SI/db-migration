-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_asset_type_meta labpkl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labpkl_asset_type_meta labpkl_asset_type_meta_id; Type: CONSTRAINT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.labpkl_asset_type_meta
    ADD CONSTRAINT labpkl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
