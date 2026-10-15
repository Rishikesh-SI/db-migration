-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: u17wc_web_user web_user_id_pk; Type: CONSTRAINT; Schema: u17wc; Owner: -
--

ALTER TABLE ONLY u17wc.u17wc_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
