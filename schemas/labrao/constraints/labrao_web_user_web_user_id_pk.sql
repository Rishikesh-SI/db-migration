-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labrao_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labrao; Owner: -
--

ALTER TABLE ONLY labrao.labrao_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
