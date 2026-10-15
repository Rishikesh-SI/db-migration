-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_newsletter_subscription labbsc_dev_user_newsletter_subscription_pkey
-- Type: CONSTRAINT

-- Name: labbsc_dev_user_newsletter_subscription labbsc_dev_user_newsletter_subscription_pkey; Type: CONSTRAINT; Schema: labbsc_dev; Owner: -
--

ALTER TABLE ONLY labbsc_dev.labbsc_dev_user_newsletter_subscription
    ADD CONSTRAINT labbsc_dev_user_newsletter_subscription_pkey PRIMARY KEY (user_id);


--
