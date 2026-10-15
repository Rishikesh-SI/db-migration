-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_user_role labkc_user_role_id
-- Type: CONSTRAINT

-- Name: labkc_user_role labkc_user_role_id; Type: CONSTRAINT; Schema: labkc; Owner: -
--

ALTER TABLE ONLY labkc.labkc_user_role
    ADD CONSTRAINT labkc_user_role_id PRIMARY KEY (user_role_id);


--
