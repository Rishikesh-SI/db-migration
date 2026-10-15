-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labmi_v1_web_user email_id_unq; Type: CONSTRAINT; Schema: labmi_v1_bkp; Owner: -
--

ALTER TABLE ONLY labmi_v1_bkp.labmi_v1_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
