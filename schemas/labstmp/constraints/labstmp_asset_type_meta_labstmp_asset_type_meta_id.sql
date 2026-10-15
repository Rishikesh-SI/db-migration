-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_asset_type_meta labstmp_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labstmp_asset_type_meta labstmp_asset_type_meta_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_asset_type_meta
    ADD CONSTRAINT labstmp_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
