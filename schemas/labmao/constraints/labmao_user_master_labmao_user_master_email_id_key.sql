-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_user_master labmao_user_master_email_id_key
-- Type: CONSTRAINT

-- Name: labmao_user_master labmao_user_master_email_id_key; Type: CONSTRAINT; Schema: labmao; Owner: -
--

ALTER TABLE ONLY labmao.labmao_user_master
    ADD CONSTRAINT labmao_user_master_email_id_key UNIQUE (email_id);


--
