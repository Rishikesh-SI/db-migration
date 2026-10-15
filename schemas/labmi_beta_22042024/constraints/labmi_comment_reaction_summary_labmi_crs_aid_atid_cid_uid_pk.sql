-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_comment_reaction_summary labmi_crs_aid_atid_cid_uid_pk
-- Type: CONSTRAINT

-- Name: labmi_comment_reaction_summary labmi_crs_aid_atid_cid_uid_pk; Type: CONSTRAINT; Schema: labmi_beta_22042024; Owner: -
--

ALTER TABLE ONLY labmi_beta_22042024.labmi_comment_reaction_summary
    ADD CONSTRAINT labmi_crs_aid_atid_cid_uid_pk PRIMARY KEY (asset_id, asset_type_id, comment_id, user_id);


--
