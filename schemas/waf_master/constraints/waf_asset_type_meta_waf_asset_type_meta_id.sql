-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_asset_type_meta waf_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: waf_asset_type_meta waf_asset_type_meta_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_asset_type_meta
    ADD CONSTRAINT waf_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
