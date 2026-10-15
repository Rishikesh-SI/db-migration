-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labmcfc_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labmcfc; Owner: -
--

ALTER TABLE ONLY labmcfc.labmcfc_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
