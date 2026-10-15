-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_asset_group waf_asset_group_id
-- Type: CONSTRAINT

-- Name: waf_asset_group waf_asset_group_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_asset_group
    ADD CONSTRAINT waf_asset_group_id PRIMARY KEY (asset_group_id);


--
