-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_user_activity spz_user_activity_id
-- Type: CONSTRAINT

-- Name: spz_user_activity spz_user_activity_id; Type: CONSTRAINT; Schema: spz; Owner: -
--

ALTER TABLE ONLY spz.spz_user_activity
    ADD CONSTRAINT spz_user_activity_id PRIMARY KEY (user_activity_id);


--
