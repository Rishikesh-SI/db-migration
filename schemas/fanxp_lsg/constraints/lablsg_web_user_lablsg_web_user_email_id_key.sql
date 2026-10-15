-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_web_user lablsg_web_user_email_id_key
-- Type: CONSTRAINT

-- Name: lablsg_web_user lablsg_web_user_email_id_key; Type: CONSTRAINT; Schema: fanxp_lsg; Owner: -
--

ALTER TABLE ONLY fanxp_lsg.lablsg_web_user
    ADD CONSTRAINT lablsg_web_user_email_id_key UNIQUE (email_id);


--
