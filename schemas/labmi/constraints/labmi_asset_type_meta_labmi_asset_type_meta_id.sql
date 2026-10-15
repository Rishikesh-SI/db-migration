-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_asset_type_meta labmi_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labmi_asset_type_meta labmi_asset_type_meta_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_asset_type_meta
    ADD CONSTRAINT labmi_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
