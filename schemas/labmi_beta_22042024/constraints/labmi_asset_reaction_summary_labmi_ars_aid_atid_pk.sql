-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_asset_reaction_summary labmi_ars_aid_atid_pk
-- Type: CONSTRAINT

-- Name: labmi_asset_reaction_summary labmi_ars_aid_atid_pk; Type: CONSTRAINT; Schema: labmi_beta_22042024; Owner: -
--

ALTER TABLE ONLY labmi_beta_22042024.labmi_asset_reaction_summary
    ADD CONSTRAINT labmi_ars_aid_atid_pk PRIMARY KEY (asset_id, asset_type_id);


--
