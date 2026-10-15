-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_asset_type_meta labtcs_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labtcs_asset_type_meta labtcs_asset_type_meta_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_asset_type_meta
    ADD CONSTRAINT labtcs_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
