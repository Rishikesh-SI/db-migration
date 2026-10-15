-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_asset_type_meta hsl_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labhsl_asset_type_meta hsl_asset_type_meta_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_asset_type_meta
    ADD CONSTRAINT hsl_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
