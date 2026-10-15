-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_user_role ppb_user_role_id
-- Type: CONSTRAINT

-- Name: ppb_user_role ppb_user_role_id; Type: CONSTRAINT; Schema: ppb; Owner: -
--

ALTER TABLE ONLY ppb.ppb_user_role
    ADD CONSTRAINT ppb_user_role_id PRIMARY KEY (user_role_id);


--
