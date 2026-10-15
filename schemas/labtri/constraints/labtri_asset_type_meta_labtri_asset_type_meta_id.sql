-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_asset_type_meta labtri_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labtri_asset_type_meta labtri_asset_type_meta_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_asset_type_meta
    ADD CONSTRAINT labtri_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
