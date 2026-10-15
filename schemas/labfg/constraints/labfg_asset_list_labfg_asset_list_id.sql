-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_asset_list labfg_asset_list_id
-- Type: CONSTRAINT

-- Name: labfg_asset_list labfg_asset_list_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_asset_list
    ADD CONSTRAINT labfg_asset_list_id PRIMARY KEY (asset_list_id);


--
