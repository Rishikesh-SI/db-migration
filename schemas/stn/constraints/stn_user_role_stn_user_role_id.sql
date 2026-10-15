-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_user_role stn_user_role_id
-- Type: CONSTRAINT

-- Name: stn_user_role stn_user_role_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_user_role
    ADD CONSTRAINT stn_user_role_id PRIMARY KEY (user_role_id);


--
