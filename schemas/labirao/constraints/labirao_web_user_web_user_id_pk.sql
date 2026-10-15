-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labirao_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labirao; Owner: -
--

ALTER TABLE ONLY labirao.labirao_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
