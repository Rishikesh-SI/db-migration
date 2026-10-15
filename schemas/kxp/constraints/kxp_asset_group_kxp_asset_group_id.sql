-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_asset_group kxp_asset_group_id
-- Type: CONSTRAINT

-- Name: kxp_asset_group kxp_asset_group_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_asset_group
    ADD CONSTRAINT kxp_asset_group_id PRIMARY KEY (asset_group_id);


--
