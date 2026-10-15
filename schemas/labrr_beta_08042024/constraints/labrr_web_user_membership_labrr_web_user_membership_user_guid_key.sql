-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_web_user_membership labrr_web_user_membership_user_guid_key
-- Type: CONSTRAINT

-- Name: labrr_web_user_membership labrr_web_user_membership_user_guid_key; Type: CONSTRAINT; Schema: labrr_beta_08042024; Owner: -
--

ALTER TABLE ONLY labrr_beta_08042024.labrr_web_user_membership
    ADD CONSTRAINT labrr_web_user_membership_user_guid_key UNIQUE (user_guid);


--
