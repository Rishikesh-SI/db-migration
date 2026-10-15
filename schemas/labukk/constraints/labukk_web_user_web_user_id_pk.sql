-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labukk_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labukk; Owner: -
--

ALTER TABLE ONLY labukk.labukk_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
