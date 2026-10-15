-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_user_event_subscription_map gpn_user_event_subscription_map_id_pk
-- Type: CONSTRAINT

-- Name: gpn_user_event_subscription_map gpn_user_event_subscription_map_id_pk; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_user_event_subscription_map
    ADD CONSTRAINT gpn_user_event_subscription_map_id_pk PRIMARY KEY (user_event_subscription_map_id);


--
