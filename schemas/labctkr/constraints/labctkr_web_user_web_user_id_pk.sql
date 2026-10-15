-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labctkr_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labctkr; Owner: -
--

ALTER TABLE ONLY labctkr.labctkr_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
