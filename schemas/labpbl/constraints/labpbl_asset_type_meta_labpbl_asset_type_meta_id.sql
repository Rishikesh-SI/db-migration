-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_asset_type_meta labpbl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labpbl_asset_type_meta labpbl_asset_type_meta_id; Type: CONSTRAINT; Schema: labpbl; Owner: -
--

ALTER TABLE ONLY labpbl.labpbl_asset_type_meta
    ADD CONSTRAINT labpbl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
