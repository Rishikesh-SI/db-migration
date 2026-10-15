-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_journey_activity user_activity_cart_id_pk
-- Type: CONSTRAINT

-- Name: labbsc_user_journey_activity user_activity_cart_id_pk; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_user_journey_activity
    ADD CONSTRAINT user_activity_cart_id_pk UNIQUE (user_id, activity_id, cart_id);


--
