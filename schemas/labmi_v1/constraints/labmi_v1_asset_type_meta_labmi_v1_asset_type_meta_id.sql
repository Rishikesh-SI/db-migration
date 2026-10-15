-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_asset_type_meta labmi_v1_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labmi_v1_asset_type_meta labmi_v1_asset_type_meta_id; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_asset_type_meta
    ADD CONSTRAINT labmi_v1_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
