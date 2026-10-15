-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labmi_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labmi; Owner: -
--

ALTER TABLE ONLY labmi.labmi_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
