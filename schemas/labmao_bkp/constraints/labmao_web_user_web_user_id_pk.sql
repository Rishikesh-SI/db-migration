-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labmao_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labmao_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labmao_bkp; Owner: -
--

ALTER TABLE ONLY labmao_bkp.labmao_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
