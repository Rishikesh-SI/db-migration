-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_poll_response labgrl_poll_response_id
-- Type: CONSTRAINT

-- Name: labgrl_poll_response labgrl_poll_response_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_poll_response
    ADD CONSTRAINT labgrl_poll_response_id PRIMARY KEY (poll_response_id);


--
