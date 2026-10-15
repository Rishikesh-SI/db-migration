-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labisp_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
