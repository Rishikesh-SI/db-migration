-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labmsg_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
