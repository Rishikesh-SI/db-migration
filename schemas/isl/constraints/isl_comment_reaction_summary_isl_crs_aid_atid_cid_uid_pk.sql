-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_comment_reaction_summary isl_crs_aid_atid_cid_uid_pk
-- Type: CONSTRAINT

-- Name: isl_comment_reaction_summary isl_crs_aid_atid_cid_uid_pk; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_comment_reaction_summary
    ADD CONSTRAINT isl_crs_aid_atid_cid_uid_pk PRIMARY KEY (asset_id, asset_type_id, comment_id, user_id);


--
