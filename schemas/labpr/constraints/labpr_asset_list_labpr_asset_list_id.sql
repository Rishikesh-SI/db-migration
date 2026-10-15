-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_asset_list labpr_asset_list_id
-- Type: CONSTRAINT

-- Name: labpr_asset_list labpr_asset_list_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_asset_list
    ADD CONSTRAINT labpr_asset_list_id PRIMARY KEY (asset_list_id);


--
