-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labdms_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
