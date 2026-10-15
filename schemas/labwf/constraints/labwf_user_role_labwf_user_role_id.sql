-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_user_role labwf_user_role_id
-- Type: CONSTRAINT

-- Name: labwf_user_role labwf_user_role_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_user_role
    ADD CONSTRAINT labwf_user_role_id PRIMARY KEY (user_role_id);


--
