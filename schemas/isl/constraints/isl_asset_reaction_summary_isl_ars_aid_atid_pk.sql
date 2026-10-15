-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_asset_reaction_summary isl_ars_aid_atid_pk
-- Type: CONSTRAINT

-- Name: isl_asset_reaction_summary isl_ars_aid_atid_pk; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_asset_reaction_summary
    ADD CONSTRAINT isl_ars_aid_atid_pk PRIMARY KEY (asset_id, asset_type_id);


--
