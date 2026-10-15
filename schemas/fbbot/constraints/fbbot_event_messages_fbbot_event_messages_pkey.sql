-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_event_messages fbbot_event_messages_pkey
-- Type: CONSTRAINT

-- Name: fbbot_event_messages fbbot_event_messages_pkey; Type: CONSTRAINT; Schema: fbbot; Owner: -
--

ALTER TABLE ONLY fbbot.fbbot_event_messages
    ADD CONSTRAINT fbbot_event_messages_pkey PRIMARY KEY (event_message_id);


--
