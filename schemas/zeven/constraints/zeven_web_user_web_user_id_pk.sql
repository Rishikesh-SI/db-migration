-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: zeven_web_user web_user_id_pk; Type: CONSTRAINT; Schema: zeven; Owner: -
--

ALTER TABLE ONLY zeven.zeven_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
