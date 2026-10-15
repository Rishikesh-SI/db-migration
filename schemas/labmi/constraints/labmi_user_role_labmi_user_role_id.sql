-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_user_role labmi_user_role_id
-- Type: CONSTRAINT

-- Name: labmi_user_role labmi_user_role_id; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_user_role
    ADD CONSTRAINT labmi_user_role_id PRIMARY KEY (user_role_id);


--
