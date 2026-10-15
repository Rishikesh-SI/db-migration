-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_asset_group hsl_asset_group_id
-- Type: CONSTRAINT

-- Name: hsl_asset_group hsl_asset_group_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_asset_group
    ADD CONSTRAINT hsl_asset_group_id PRIMARY KEY (asset_group_id);


--
