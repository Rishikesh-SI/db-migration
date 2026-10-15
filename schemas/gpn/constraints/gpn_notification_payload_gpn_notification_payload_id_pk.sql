-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_notification_payload gpn_notification_payload_id_pk
-- Type: CONSTRAINT

-- Name: gpn_notification_payload gpn_notification_payload_id_pk; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_notification_payload
    ADD CONSTRAINT gpn_notification_payload_id_pk PRIMARY KEY (notification_payload_id);


--
