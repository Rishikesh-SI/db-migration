-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_user_role labupw_user_role_id
-- Type: CONSTRAINT

-- Name: labupw_user_role labupw_user_role_id; Type: CONSTRAINT; Schema: labupw; Owner: -
--

ALTER TABLE ONLY labupw.labupw_user_role
    ADD CONSTRAINT labupw_user_role_id PRIMARY KEY (user_role_id);


--
