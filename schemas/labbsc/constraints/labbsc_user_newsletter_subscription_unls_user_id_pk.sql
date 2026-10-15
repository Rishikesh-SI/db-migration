-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_newsletter_subscription unls_user_id_pk
-- Type: CONSTRAINT

-- Name: labbsc_user_newsletter_subscription unls_user_id_pk; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_user_newsletter_subscription
    ADD CONSTRAINT unls_user_id_pk PRIMARY KEY (user_id);


--
