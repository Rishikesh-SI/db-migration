-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_user_role spz_user_role_id
-- Type: CONSTRAINT

-- Name: spz_user_role spz_user_role_id; Type: CONSTRAINT; Schema: spz; Owner: -
--

ALTER TABLE ONLY spz.spz_user_role
    ADD CONSTRAINT spz_user_role_id PRIMARY KEY (user_role_id);


--
