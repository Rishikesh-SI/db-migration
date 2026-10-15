-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_asset_type_meta labrstg_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labrstg_asset_type_meta labrstg_asset_type_meta_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_asset_type_meta
    ADD CONSTRAINT labrstg_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
