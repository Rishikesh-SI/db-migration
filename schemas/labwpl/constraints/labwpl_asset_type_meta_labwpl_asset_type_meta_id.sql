-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_asset_type_meta labwpl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labwpl_asset_type_meta labwpl_asset_type_meta_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_asset_type_meta
    ADD CONSTRAINT labwpl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
