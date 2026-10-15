-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_poll_asset_map waf_poll_asset_map_id
-- Type: CONSTRAINT

-- Name: waf_poll_asset_map waf_poll_asset_map_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_poll_asset_map
    ADD CONSTRAINT waf_poll_asset_map_id PRIMARY KEY (poll_asset_map_id);


--
