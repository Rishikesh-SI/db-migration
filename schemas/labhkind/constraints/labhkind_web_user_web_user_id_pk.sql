-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labhkind_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
