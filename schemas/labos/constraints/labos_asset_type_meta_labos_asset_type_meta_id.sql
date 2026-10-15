-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_asset_type_meta labos_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labos_asset_type_meta labos_asset_type_meta_id; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_asset_type_meta
    ADD CONSTRAINT labos_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
