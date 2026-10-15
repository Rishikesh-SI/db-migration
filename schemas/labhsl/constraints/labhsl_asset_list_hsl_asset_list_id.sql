-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_asset_list hsl_asset_list_id
-- Type: CONSTRAINT

-- Name: labhsl_asset_list hsl_asset_list_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_asset_list
    ADD CONSTRAINT hsl_asset_list_id PRIMARY KEY (asset_list_id);


--
