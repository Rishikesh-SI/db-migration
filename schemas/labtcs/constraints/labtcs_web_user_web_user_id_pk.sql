-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labtcs_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
