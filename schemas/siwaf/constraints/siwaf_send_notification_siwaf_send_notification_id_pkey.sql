-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_send_notification siwaf_send_notification_id_pkey
-- Type: CONSTRAINT

-- Name: siwaf_send_notification siwaf_send_notification_id_pkey; Type: CONSTRAINT; Schema: siwaf; Owner: -
--

ALTER TABLE ONLY siwaf.siwaf_send_notification
    ADD CONSTRAINT siwaf_send_notification_id_pkey PRIMARY KEY (notification_data_id);


--
