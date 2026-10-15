-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_user_role labpbl_user_role_id
-- Type: CONSTRAINT

-- Name: labpbl_user_role labpbl_user_role_id; Type: CONSTRAINT; Schema: labpbl; Owner: -
--

ALTER TABLE ONLY labpbl.labpbl_user_role
    ADD CONSTRAINT labpbl_user_role_id PRIMARY KEY (user_role_id);


--
