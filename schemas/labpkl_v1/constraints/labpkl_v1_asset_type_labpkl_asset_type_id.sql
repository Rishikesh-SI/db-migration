-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_asset_type labpkl_asset_type_id
-- Type: CONSTRAINT

-- Name: labpkl_v1_asset_type labpkl_asset_type_id; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.labpkl_v1_asset_type
    ADD CONSTRAINT labpkl_asset_type_id PRIMARY KEY (asset_type_id);


--
