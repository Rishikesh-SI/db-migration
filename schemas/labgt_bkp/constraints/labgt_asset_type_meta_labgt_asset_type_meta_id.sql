-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_asset_type_meta labgt_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labgt_asset_type_meta labgt_asset_type_meta_id; Type: CONSTRAINT; Schema: labgt_bkp; Owner: -
--

ALTER TABLE ONLY labgt_bkp.labgt_asset_type_meta
    ADD CONSTRAINT labgt_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
