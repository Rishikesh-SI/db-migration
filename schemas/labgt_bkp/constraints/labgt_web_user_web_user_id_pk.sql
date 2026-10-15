-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labgt_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labgt_bkp; Owner: -
--

ALTER TABLE ONLY labgt_bkp.labgt_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
