-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_journey_activity labbsc_dev_user_journey_activit_user_id_activity_id_cart_id_key
-- Type: CONSTRAINT

-- Name: labbsc_dev_user_journey_activity labbsc_dev_user_journey_activit_user_id_activity_id_cart_id_key; Type: CONSTRAINT; Schema: labbsc_dev; Owner: -
--

ALTER TABLE ONLY labbsc_dev.labbsc_dev_user_journey_activity
    ADD CONSTRAINT labbsc_dev_user_journey_activit_user_id_activity_id_cart_id_key UNIQUE (user_id, activity_id, cart_id);


--
