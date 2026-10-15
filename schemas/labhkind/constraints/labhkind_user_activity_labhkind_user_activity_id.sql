-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_user_activity labhkind_user_activity_id
-- Type: CONSTRAINT

-- Name: labhkind_user_activity labhkind_user_activity_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_user_activity
    ADD CONSTRAINT labhkind_user_activity_id PRIMARY KEY (user_activity_id);


--
