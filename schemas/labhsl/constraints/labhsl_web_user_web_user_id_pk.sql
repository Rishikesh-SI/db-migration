-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labhsl_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
