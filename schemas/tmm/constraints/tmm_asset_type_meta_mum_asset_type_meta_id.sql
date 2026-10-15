-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_asset_type_meta mum_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: tmm_asset_type_meta mum_asset_type_meta_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_asset_type_meta
    ADD CONSTRAINT mum_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
