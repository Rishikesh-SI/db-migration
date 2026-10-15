-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_subscription gpn_subscription_id_pk
-- Type: CONSTRAINT

-- Name: gpn_subscription gpn_subscription_id_pk; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_subscription
    ADD CONSTRAINT gpn_subscription_id_pk PRIMARY KEY (subscription_id);


--
