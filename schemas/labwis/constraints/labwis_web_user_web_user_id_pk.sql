-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labwis_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
