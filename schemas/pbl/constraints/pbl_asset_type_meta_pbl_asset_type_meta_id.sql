-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_asset_type_meta pbl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: pbl_asset_type_meta pbl_asset_type_meta_id; Type: CONSTRAINT; Schema: pbl; Owner: -
--

ALTER TABLE ONLY pbl.pbl_asset_type_meta
    ADD CONSTRAINT pbl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
