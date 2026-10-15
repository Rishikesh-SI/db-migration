-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labkc_v1_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labkc_v1_bkp; Owner: -
--

ALTER TABLE ONLY labkc_v1_bkp.labkc_v1_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
