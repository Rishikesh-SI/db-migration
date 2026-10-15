-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_user labhkind_user_id
-- Type: CONSTRAINT

-- Name: labhkind_user labhkind_user_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_user
    ADD CONSTRAINT labhkind_user_id PRIMARY KEY (user_id);


--
