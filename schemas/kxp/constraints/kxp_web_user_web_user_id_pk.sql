-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: kxp_web_user web_user_id_pk; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
