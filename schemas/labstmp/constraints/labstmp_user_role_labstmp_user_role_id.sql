-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_user_role labstmp_user_role_id
-- Type: CONSTRAINT

-- Name: labstmp_user_role labstmp_user_role_id; Type: CONSTRAINT; Schema: labstmp; Owner: -
--

ALTER TABLE ONLY labstmp.labstmp_user_role
    ADD CONSTRAINT labstmp_user_role_id PRIMARY KEY (user_role_id);


--
