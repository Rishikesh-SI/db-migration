-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labpr_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
