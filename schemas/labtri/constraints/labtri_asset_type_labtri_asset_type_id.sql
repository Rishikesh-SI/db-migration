-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_asset_type labtri_asset_type_id
-- Type: CONSTRAINT

-- Name: labtri_asset_type labtri_asset_type_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_asset_type
    ADD CONSTRAINT labtri_asset_type_id PRIMARY KEY (asset_type_id);


--
