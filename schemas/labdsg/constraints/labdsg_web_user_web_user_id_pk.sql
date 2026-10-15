-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labdsg_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
