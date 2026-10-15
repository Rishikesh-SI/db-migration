-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_user_role labpr_user_role_id
-- Type: CONSTRAINT

-- Name: labpr_user_role labpr_user_role_id; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_user_role
    ADD CONSTRAINT labpr_user_role_id PRIMARY KEY (user_role_id);


--
