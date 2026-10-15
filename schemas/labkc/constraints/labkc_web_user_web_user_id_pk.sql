-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labkc_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labkc; Owner: -
--

ALTER TABLE ONLY labkc.labkc_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
