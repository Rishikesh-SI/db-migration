-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labdsp_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labdsp; Owner: -
--

ALTER TABLE ONLY labdsp.labdsp_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
