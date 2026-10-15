-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labwf_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
