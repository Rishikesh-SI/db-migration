-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_asset_type_meta mum_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: tmmimg_upd_asset_type_meta mum_asset_type_meta_id; Type: CONSTRAINT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_asset_type_meta
    ADD CONSTRAINT mum_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
