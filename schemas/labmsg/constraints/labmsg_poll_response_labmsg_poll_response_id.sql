-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_poll_response labmsg_poll_response_id
-- Type: CONSTRAINT

-- Name: labmsg_poll_response labmsg_poll_response_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_poll_response
    ADD CONSTRAINT labmsg_poll_response_id PRIMARY KEY (poll_response_id);


--
