-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_asset_draft waf_asset_draft_id
-- Type: CONSTRAINT

-- Name: waf_asset_draft waf_asset_draft_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_asset_draft
    ADD CONSTRAINT waf_asset_draft_id PRIMARY KEY (asset_draft_id);


--
