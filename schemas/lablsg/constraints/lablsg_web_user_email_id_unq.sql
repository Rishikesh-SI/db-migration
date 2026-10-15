-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: lablsg_web_user email_id_unq; Type: CONSTRAINT; Schema: lablsg; Owner: -
--

ALTER TABLE ONLY lablsg.lablsg_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
