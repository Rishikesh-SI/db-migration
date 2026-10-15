-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_asset_type_meta abp_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: abp_asset_type_meta abp_asset_type_meta_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_asset_type_meta
    ADD CONSTRAINT abp_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
