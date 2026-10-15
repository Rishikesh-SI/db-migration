-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labkc_v1_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labkc_v1_02042024; Owner: -
--

ALTER TABLE ONLY labkc_v1_02042024.labkc_v1_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
