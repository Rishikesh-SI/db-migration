-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_asset_type_meta labdd_v1_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labdd_v1_asset_type_meta labdd_v1_asset_type_meta_id; Type: CONSTRAINT; Schema: labdd_v1; Owner: -
--

ALTER TABLE ONLY labdd_v1.labdd_v1_asset_type_meta
    ADD CONSTRAINT labdd_v1_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
