-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_asset_type_meta labdsp_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labdsp_asset_type_meta labdsp_asset_type_meta_id; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_asset_type_meta
    ADD CONSTRAINT labdsp_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
