-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labrs_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
