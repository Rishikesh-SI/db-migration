-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_asset_type_meta labrs_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labrs_asset_type_meta labrs_asset_type_meta_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_asset_type_meta
    ADD CONSTRAINT labrs_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
