-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_events fbbot_events_pkey
-- Type: CONSTRAINT

-- Name: fbbot_events fbbot_events_pkey; Type: CONSTRAINT; Schema: fbbot; Owner: -
--

ALTER TABLE ONLY fbbot.fbbot_events
    ADD CONSTRAINT fbbot_events_pkey PRIMARY KEY (event_id);


--
