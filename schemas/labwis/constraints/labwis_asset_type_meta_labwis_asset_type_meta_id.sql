-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_asset_type_meta labwis_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labwis_asset_type_meta labwis_asset_type_meta_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_asset_type_meta
    ADD CONSTRAINT labwis_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
