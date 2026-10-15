-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_asset_type_meta swa_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: swa_asset_type_meta swa_asset_type_meta_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_asset_type_meta
    ADD CONSTRAINT swa_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
