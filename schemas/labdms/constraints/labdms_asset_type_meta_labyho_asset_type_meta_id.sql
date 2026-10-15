-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_asset_type_meta labyho_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labdms_asset_type_meta labyho_asset_type_meta_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_asset_type_meta
    ADD CONSTRAINT labyho_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
