-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_asset_type_meta labgt_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labgt_asset_type_meta labgt_asset_type_meta_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_asset_type_meta
    ADD CONSTRAINT labgt_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
