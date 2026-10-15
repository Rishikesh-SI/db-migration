-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labmi_v1_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labmi_v1; Owner: -
--

ALTER TABLE ONLY labmi_v1.labmi_v1_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
