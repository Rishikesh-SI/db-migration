-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_asset_type hsl_asset_type_id
-- Type: CONSTRAINT

-- Name: labhsl_asset_type hsl_asset_type_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_asset_type
    ADD CONSTRAINT hsl_asset_type_id PRIMARY KEY (asset_type_id);


--
