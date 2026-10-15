-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labilt_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labilt; Owner: -
--

ALTER TABLE ONLY labilt.labilt_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
