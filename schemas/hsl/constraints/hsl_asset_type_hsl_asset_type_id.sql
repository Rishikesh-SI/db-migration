-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_asset_type hsl_asset_type_id
-- Type: CONSTRAINT

-- Name: hsl_asset_type hsl_asset_type_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_asset_type
    ADD CONSTRAINT hsl_asset_type_id PRIMARY KEY (asset_type_id);


--
